class AddResourceUrlToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :resource_url, :string
  end
end
