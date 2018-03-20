class VendorPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.super_admin_or_admin? || user.permission?(:vendor)
  end

  def destroy?
    user.super_admin_or_admin? || user.permission?(:vendor)
  end

  def update?
    user.super_admin_or_admin? || user.permission?(:vendor)
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin? || user.permission?(:vendor)
      [:name, :contact_name, :phone_number, :description]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
