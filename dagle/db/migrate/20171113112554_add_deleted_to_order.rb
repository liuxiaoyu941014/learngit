class AddDeletedToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :deleted, :boolean, default: false
  end
end
