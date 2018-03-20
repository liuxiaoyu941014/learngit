class AddCommentsCountToCmsPage < ActiveRecord::Migration[5.0]
  def change
    add_column :cms_pages, :comments_count, :integer, index: true, default: 0 
  end
end
