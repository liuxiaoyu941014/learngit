class RemoveSiteForeignKeyFromCmsComments < ActiveRecord::Migration[5.0]
  def change
    remove_column :cms_comments, :site_id

    add_column :cms_comments, :site_id, :integer, null: false, after: :id
    add_index :cms_comments, :site_id
  end
end
