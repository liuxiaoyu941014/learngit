# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  features   :jsonb
#  type       :string
#


# diymenu这个model主要功能是这样，我们会借助我们的微信开放平台获得用户公众号的微信授权，这样就可以在我们的平台上面托管微信功能，好处就是可以有多人共同管理，而它里面主要的功能在model里面都有介绍，但在文广通项目里面我们用到的主要就是
# 1.绑定商家微信账号
# 2.实现商家微信公众号菜单栏按钮的CRUD
# 3.实现内部公众账号绑定
class Site < ApplicationRecord
  MAIN_ID = 1
  belongs_to :user, optional: true
  belongs_to :catalog
  has_many :theme_configs
  has_many :staffs if Settings.project.meikemei?
  has_one :active_theme_config, -> { where(active: true) }, class_name: 'ThemeConfig'
  has_many :items, dependent: :destroy
  has_many :image_item_relations, as: :relation
  has_many :image_items, :through => :image_item_relations
  has_many :members, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :tags, through: :products
  has_many :orders, dependent: :destroy
  has_many :order_comments, through: :orders, source: :comments
  has_many :preorder_conversitions, dependent: :destroy
  has_many :market_pages, dependent: :destroy
  has_many_favorites
  has_many_comments
  has_many :deliveries, dependent: :destroy
  has_one :cms_site, class_name: '::Cms::Site', dependent: :destroy
  belongs_to :agent_plan, optional: true  #optional 选项设为 true，不会验证关联的对象是否存在
  has_many :diymenus, dependent: :destroy
  has_many :parent_menus, -> { includes(:sub_menus).where(parent_id: nil, is_show: true).order("sort").limit(3) }, class_name: "Diymenu", foreign_key: :site_id
  # store_accessor :features, :business_hours, :content, :contact_phone, :contact_name, :is_sign, :sign_note,
  # :score, :comment, :properties, :updated_by, :has_contract, :is_published, :phone, :lat, :lng
  def first_image
    image_items.first.try(:image_url) || 'http://song-dev.qiniudn.com/site.jpg'
  end

  acts_as_tree

  store_accessor :features, :description, :properties, :business_hours,
                :recommendation, :good_summary, :bad_summary, :parking,
                :wifi, :contact_name, :contact_phone, :has_contract, :contract_note,
                :avg_price, :is_published, :phone, :photos, :province, :real_city, :city, :district, :business_area,
                :updated_by, :content, :delivery_fee
  store_accessor :forage, :forage_url, :is_foraged, :forage_from, :forage_district_from, :forage_image

  validates_presence_of :title, :address_line#, :user_id
  validates_uniqueness_of :title, scope: [:address_line]


  if Settings.project.meikemei?
    PROPERTIES = {
      assure: "正品保障",
      cleaning: "卫生清洁",
      hidden_consumption: "无隐性消费",
      standard_procedure: "标准流程"
    }
  else
    PROPERTIES = {
      hot: "头条",
      recommend: "推荐",
      slider: "幻灯",
      scroll: "滚动",
      redirect: "跳转",
      hide: "隐藏"
    }
  end
  # Site.hot
  # Site.recommend(6)
  PROPERTIES.each_pair do |k, v|
    scope k, ->(count = 2) {
      where("(features -> 'properties') ? '#{k}'").reorder("updated_at DESC").limit(count)
    }
  end

  if Settings.project.imolin? || Settings.project.wgtong? || Settings.project.meikemei?
    acts_as_address
    acts_as_geolocated lat: 'lat', lng: 'lng'
    def address_lat
      # self.manual_geo ? self.manual_geo.lat : self.address.lat
      self.lat
    end

    def address_lng
      # self.manual_geo ? self.manual_geo.lng : self.address.lng
      self.lng
    end

    scope :published, -> { where("features ->> 'is_published' = ?", "1") }

     # site地址完成改动时候,经纬度也得跟着改
    before_save do |rec|
      if rec.address_line_changed?
        rec.lat = address.lat
        rec.lng = address.lng
      end
    end
  end
  audited

  if Settings.project.sxhop?
    def friends
      SalesDistribution::ResourceUser.joins(:resource).
      where("sales_distribution_resources.object_type = 'Site' and sales_distribution_resources.object_id = ?", self.id).
      pluck("sales_distribution_resource_users.user_id")
    end
  end

  def available_phone
    contact_phone.presence || phone.presence || user.try(:mobile).try(:phone_number)
  end

  def wxopen_info
    return nil if tanmer_wxopen_token.blank?
    conn = Faraday.new(:url => 'https://wxopen.tanmer.com')
    conn.headers[Faraday::Request::Authorization::KEY] = "Bear #{tanmer_wxopen_token}"
    begin
      response = conn.get("api/mp/info")
      JSON.parse(response.body)
    rescue
      nil
    end
  end

  def upload_wx_menu
    raise "no tanmer wxopen token" if tanmer_wxopen_token.blank?
    conn = Faraday.new(:url => 'https://wxopen.tanmer.com')
    conn.headers[Faraday::Request::Authorization::KEY] = "Bear #{tanmer_wxopen_token}"
    conn.headers['Content-Type'] = 'application/json'
    conn.put 'api/mp/menu', build_wx_menu
  end

  def build_wx_menu
    Jbuilder.encode do |json|
      json.button(parent_menus) do |menu|
        json.name menu.name
        if menu.has_sub_menu?
          json.sub_button(menu.sub_menus) do |sub_menu|
            json.type sub_menu.button_type
            json.name sub_menu.name
            sub_menu.button_type_json(json)
          end
        else
          json.type menu.button_type
          menu.button_type_json(json)
        end
      end
    end
  end

  def download_wx_menu!
    conn = Faraday.new(:url => 'https://wxopen.tanmer.com')
    conn.headers[Faraday::Request::Authorization::KEY] = "Bear #{tanmer_wxopen_token}"
    response = conn.get("api/mp/menu")
    data = JSON.parse(response.body)
    if data['menu'].present?
      diymenus.where(parent: nil).update_all(is_show: false)
      if data.key?('menu') && data['menu'].key?('button')
        data['menu']['button'].each_with_index do |button, i|
          sub_buttons = button.delete('sub_button')
          button['button_type'] = Diymenu::button_types[button.delete('type')]
          parent_menu = diymenus.find_or_initialize_by(button)
          parent_menu.parent = nil
          parent_menu.is_show = true
          parent_menu.sort = i + 1
          parent_menu.save! if parent_menu.changed?
          parent_menu.diymenus.update_all(parent_id: nil, is_show: false)

          sub_buttons.each_with_index do |sub_button, j|
            sub_button.delete('sub_button')
            sub_button['button_type'] = Diymenu::button_types[sub_button.delete('type')]
            sub_menu = diymenus.find_or_initialize_by(sub_button)
            sub_menu.parent = parent_menu
            sub_menu.is_show = true
            sub_menu.sort = j + 1
            sub_menu.save! if sub_menu.changed?
          end
        end
      end
    end
    data
  end

end
