class AddSourceTypeToCmsComment < ActiveRecord::Migration[5.0]
  def change
    add_column :cms_comments, :source_type, :string
  end
end