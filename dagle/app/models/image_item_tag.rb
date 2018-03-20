# == Schema Information
#
# Table name: image_item_tags
#
#  id            :integer          not null, primary key
#  image_item_id :integer
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class ImageItemTag < ApplicationRecord
  audited

  belongs_to :image_item
end
