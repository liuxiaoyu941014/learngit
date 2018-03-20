class AddIsHotToCatalogs < ActiveRecord::Migration[5.0]
  def change
    add_column :catalogs, :is_hot, :boolean, index: true, default: false
  end
end
