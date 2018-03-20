class AddSalesCountToItems < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :sales_count, :integer, default: 0, index: true
  end
end
