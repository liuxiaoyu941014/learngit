class AddFeaturesToMaterialPurchaseDetail < ActiveRecord::Migration[5.0]
  def change
    add_column :material_purchase_details, :features, :jsonb
  end
end
