class AddIsPublishedToCmsComments < ActiveRecord::Migration[5.0]
  def change
    add_column :cms_comments, :is_published, :boolean, default: true
  end
end
