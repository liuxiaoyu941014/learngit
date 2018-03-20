# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  site_id    :integer
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  features   :jsonb
#  type       :string
#

class Staff < ApplicationRecord
  MAIN_ID = 1
  belongs_to :site
  has_many :theme_configs
  has_one :active_theme_config, -> { where(active: true) }, class_name: 'ThemeConfig'
  has_many :image_item_relations, as: :relation
  has_many :image_items, :through => :image_item_relations
  has_many_favorites
  store_accessor :features, :description, :age, :work_years, :content, :certificate, :properties, :score, :total_service, :week_service
  validates_presence_of :title
  validates_uniqueness_of :title

  PROPERTIES = {
    breast_dredge: "乳腺疏通",
    slimming_shaping: "瘦身塑形",
    meridian_dredging: "经络疏通",
    health_conditioning: "健康调理",
    neck_physiotherapy: "颈肩理疗",
    waist_nursing: "腰背护理",
    facial_muscle: "面部拔筋",
    facial_fever: "面部挂痧",
    pox_conditioning: "痘肌调理",
    lymphatic_drainage: "淋巴排毒",
    five_organs: "五脏调理",
    gastrointestinal_health: "肠胃保健",
    health_knowledge: "养身知识",
    skin_knowledge: "皮肤知识",
    ovary_care: "卵巢护理",
    head_physiotherapy: "头部理疗"
  }

  def headshot
    image_items.first.try(:image_url)
  end

end