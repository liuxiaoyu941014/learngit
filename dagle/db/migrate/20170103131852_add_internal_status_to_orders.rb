class AddInternalStatusToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :internal_status, :integer
  end
end
