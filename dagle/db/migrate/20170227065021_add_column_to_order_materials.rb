class AddColumnToOrderMaterials < ActiveRecord::Migration[5.0]
  def change
    add_column :order_materials, :factory_expected_number, :integer #厂长期望领取数
    add_column :order_materials, :practical_number, :integer #实际领取数
  end
end
