class RemoveImageFromImageItems < ActiveRecord::Migration[5.0]
  def change
    remove_attachment :image_items, :image
  end
end
