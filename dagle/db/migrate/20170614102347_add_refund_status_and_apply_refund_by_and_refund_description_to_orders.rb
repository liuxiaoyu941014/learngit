class AddRefundStatusAndApplyRefundByAndRefundDescriptionToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :refund_status, :integer, index: true
    add_column :orders, :apply_refund_by, :integer, index: true
    add_column :orders, :refund_description, :text
  end
end
