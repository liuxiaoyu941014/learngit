class Community < ApplicationRecord
  audited
  acts_as_address
  validates_presence_of :name, :address_line
  # ["uid", "name", "province", "city", "district", "street", "address", "telephone", "lat", "lng", "tags", "image", "keyword"]
  store_accessor :features, :uid, :province, :city, :district, :street, :address_str, :telephone, :tags, :image, :keyword

  has_many :chat_rooms, as: :owner, class_name: 'Chat::Room', dependent: :destroy
  has_many :user_communities, dependent: :destroy
  has_many :users, through: :user_communities
  has_many :articles, dependent: :destroy
  acts_as_geolocated lat: 'lat', lng: 'lng'

  def address_lat
    self.lat
  end

  def address_lng
    self.lng
  end

  scope :published, -> { where(is_published: true) }

  # 小区地址完成改动时候,经纬度也得跟着改
  before_save do |rec|
    if rec.address_line_changed?
      rec.lat = address.lat
      rec.lng = address.lng
    end
  end
end
