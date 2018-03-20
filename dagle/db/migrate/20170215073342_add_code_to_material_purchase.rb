class AddCodeToMaterialPurchase < ActiveRecord::Migration[5.0]
  def change
    add_column :material_purchases, :code, :string
  end
end
