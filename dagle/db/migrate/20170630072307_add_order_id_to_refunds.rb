class AddOrderIdToRefunds < ActiveRecord::Migration[5.0]
  def change
    add_column :refunds, :order_id, :integer
  end
end
