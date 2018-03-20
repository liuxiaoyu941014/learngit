class AddCreateByAndUpdateByToOrder < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :create_by, :integer
    add_column :orders, :update_by, :integer
  end
end
