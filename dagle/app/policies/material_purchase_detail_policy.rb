class MaterialPurchaseDetailPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user.super_admin_or_admin? || user.permission?(:purchase)
  end

  def destroy?
    user.super_admin_or_admin? || user.permission?(:purchase)
  end

  def permitted_attributes_for_create
    if user.has_role? :admin
      [:number, :price]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
