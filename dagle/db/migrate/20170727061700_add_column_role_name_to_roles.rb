class AddColumnRoleNameToRoles < ActiveRecord::Migration[5.0]
  def change
    add_column :roles, :role_name, :string
  end
end

# roles:
#   super_admin: '超级管理员'
#   admin: "管理员"
#   agent: '商家'
#   user: '用户'
#   factory_manager: "厂长"
#   product_manager: "总经销商"
#   storekeeper: "库管员"
#   designer: "设计"
#   worker: "操作员"
#   allocator: "拆单员"
#   purchase: "采购"
