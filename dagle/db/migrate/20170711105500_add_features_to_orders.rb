class AddFeaturesToOrders < ActiveRecord::Migration[5.0]
  def change
    add_column :orders, :features, :jsonb
  end
end
