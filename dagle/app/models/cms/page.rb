# == Schema Information
#
# Table name: cms_pages
#
#  id          :integer          not null, primary key
#  channel_id  :integer          not null
#  title       :string           not null
#  short_title :string           not null
#  properties  :array
#  keywords    :string
#  description :string
#  image_path  :string
#  content     :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Cms::Page < ApplicationRecord
  audited
  store_accessor :forage, :forage_url, :is_foraged, :forage_from, :forage_district_from, :forage_image
  paginates_per 12

  is_impressionable :counter_cache => true
  acts_as_taggable
  belongs_to :channel
  has_one :site, through: :channel
  has_many_comments
  before_validation :sanitize_short_title
  before_validation :create_unique_short_title
  validates :channel, :title, :content, presence: true
  # validates :short_title, format: { with: /\A[a-zA-Z0-9-]+\z/,
  #   message: "名称简写只能包括字母数字和横线" }
  validates_uniqueness_of :short_title, scope: [:channel_id]

  before_save :set_content_image
  before_save :set_thumb_image_path

  # pg array
  # Cms::Page.where("'hot' = ANY (properties)")
  # @channel.pages.where("'recommend' = ANY(properties)")
  PROPERTIES = {
    hot: "头条",
    recommend: "推荐",
    slider: "幻灯",
    scroll: "滚动",
    redirect: "跳转",
    hide: "隐藏"
  }
  # Cms::Page.hot(site_id)
  # Cms::Page.recommend(site_id, 6)
  PROPERTIES.each_pair do |k, v|
    scope k, ->(site_id, count = 2, options = {}) {
      assoc = joins(:channel).where("cms_channels.site_id = ? AND '#{k}' = ANY(cms_pages.properties)", site_id).reorder("updated_at DESC").limit(count)
      if options[:channel].present?
        assoc = assoc.joins(:channel).where(cms_channels: { short_title: options[:channel] })
      end
      assoc
    }
  end

  #scope
  default_scope -> {order(updated_at: :desc)}
  #最近新闻
  #eg: Cms::Page.recent(12, 12, :rand => true)
  #    Cms::Page.recent(1, 10, :channel => 'product-bed')
  #    Cms::Page.recent(1, 10, :channels => ['product-bed', 'product-red'])
  scope :recent, ->(site_id, count = 10, options = {}) {
    assoc = joins(:channel).where('cms_channels.site_id = ?', site_id).reorder("updated_at DESC").limit(count)
    if options[:channel].present?
      assoc = assoc.joins(:channel).where(cms_channels: { short_title: options[:channel] })
    end
    if options[:channels] && options[:channels].any?
      assoc = assoc.joins(:channel).where("cms_channels.short_title in (?) ", options[:channels])
    end
    assoc
  }
  scope :search, ->(site_id, q) { joins(:channel).where('cms_channels.site_id = ? AND cms_pages.title LIKE ?', site_id, "%#{q}%") }


  def format_date
    self.updated_at.strftime("%Y-%m-%d") unless self.updated_at.nil?
  end

  def thumb_image_path
    return if image_path.blank?
    self.image_path.sub(/content|medium|original/, 'thumb')
  end

  def original_image_path
    return if image_path.blank?
    self.image_path.sub(/content|medium|thumb/, 'original')
  end

  def show_image
    image_path.blank? ? 'http://song-dev.qiniudn.com/placeholder-300x225.jpg' : thumb_image_path
  end

  private

  def sanitize_short_title
    self.short_title = short_title.parameterize unless short_title.nil?
  end

  def create_unique_short_title
    return if short_title.present?
    s_title = Pinyin.t(title).parameterize[0..50]
    suffix = nil
    loop do
      self.short_title = "#{s_title}#{suffix}"
      query = channel.pages.where(short_title: short_title)
      query = query.where("id != ?", id) if self.persisted?
      break unless query.exists?
      suffix ||= '-'
      suffix += ('a'..'z').to_a.sample
    end
  end

 #set image_path to thumb
 def set_thumb_image_path
   if image_path =~ /\/(content|medium|original)\./
     image_path.sub!(/\/(content|medium|original)\./, '/thumb.')
   end
 end

 #remove width/height style, add class='img-responsive'
 def set_content_image
   doc = Nokogiri::HTML(content)
   begin
     doc.search("img").each do |img|
       img.remove_attribute("style")
       if img.attributes["class"].nil?
         img.set_attribute("class", "img-responsive")
       elsif (val = img.attribute("class").value) !~ /img-responsive/
         img.set_attribute("class", "#{val} img-responsive")
       end
     end
   rescue => ex
     puts ex.message
   end
   self.content = doc.at("body").inner_html
 end

end
