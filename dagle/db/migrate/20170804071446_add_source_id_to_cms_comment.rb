class AddSourceIdToCmsComment < ActiveRecord::Migration[5.0]
  def change
    add_column :cms_comments, :source_id, :integer
  end
end