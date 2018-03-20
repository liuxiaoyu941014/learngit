class AddAttachmentImageToImageItems < ActiveRecord::Migration
  def self.up
    change_table :image_items do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :image_items, :image
  end
end
