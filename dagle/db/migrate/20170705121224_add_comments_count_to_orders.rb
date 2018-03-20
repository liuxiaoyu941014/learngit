class AddCommentsCountToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :comments_count, :integer, index: true, default: 0
  end
end
