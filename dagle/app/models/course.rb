class Course < ApplicationRecord
  audited
  has_many :image_item_relations, as: :relation
  has_many :image_items, :through => :image_item_relations
  def first_image
    image_items.first.try(:image_url) || 'http://song-dev.qiniudn.com/product.jpg'
  end

end
