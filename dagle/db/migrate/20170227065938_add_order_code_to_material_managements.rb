class AddOrderCodeToMaterialManagements < ActiveRecord::Migration[5.0]
  def change
    add_column :material_managements, :order_code, :string #关联订单号
  end
end
