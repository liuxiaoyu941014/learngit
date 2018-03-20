class MaterialPurchasePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.super_admin_or_admin? || user.permission?(:purchase)
  end

  def update?
    user.super_admin_or_admin? || user.permission?(:purchase)
  end

  def destroy?
    user.super_admin_or_admin? || user.permission?(:purchase)
  end

  def audit?
    true
  end

  def update_material?
    update?
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin? || user.permission?(:purchase)
      [:purchase_date, :delivery_date, :note, :vendor_id, :status, :material_purchase_details_attributes => [:id, :material_id, :input_number, :number, :price]]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
