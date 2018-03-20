class AddColumnToCommunities < ActiveRecord::Migration[5.0]
  def change
    add_column :communities, :is_published, :boolean, default: true
    add_column :communities, :updated_by, :integer
    add_column :communities, :owned_by, :integer
    add_column :communities, :contact_info, :string
    add_column :communities, :note, :text
    add_index  :communities, :updated_by
    add_index  :communities, :owned_by
  end
end
