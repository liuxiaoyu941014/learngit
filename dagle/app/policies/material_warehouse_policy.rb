class MaterialWarehousePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.super_admin_or_admin? || user.permission?(:warehouse)
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin? || user.permission?(:warehouse)
      [:name, :warehouse_user, :phone, :warehouse_address]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
