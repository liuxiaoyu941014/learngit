class AddPurchaseStatusToOrderMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :order_materials, :purchase_status, :integer
  end
end
