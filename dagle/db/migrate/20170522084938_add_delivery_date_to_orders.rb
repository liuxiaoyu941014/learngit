class AddDeliveryDateToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :delivery_date, :date
  end
end
