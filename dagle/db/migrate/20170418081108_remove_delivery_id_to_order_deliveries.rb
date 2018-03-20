class RemoveDeliveryIdToOrderDeliveries < ActiveRecord::Migration[5.0]
  def change
    remove_column :order_deliveries, :delivery_id
  end
end
