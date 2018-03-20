class MaterialManagementPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.super_admin_or_admin? || user.permission?(:storage)
  end

  def permitted_attributes_for_create
    # fail "请在#{__FILE__}中添加params的permit属性"
    if user.super_admin_or_admin? || user.permission?(:storage) || user.permission?(:purchase)
      [:operate_date, :operate_type, :note, :order_code, :material_warehouse_id, :material_management_details_attributes => [:id, :material_id, :number, :price]]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end

end
