class MaterialPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.super_admin_or_admin? || user.permission?('create_material')
  end

  def update?
    user.super_admin_or_admin? || user.permission?('update_material')
  end

  def batch_create?
    create?
  end

  def audit?
    true
  end

  def purchase?
    show?
  end

  def get_csv?
    user.super_admin_or_admin? || user.permission?('create_material') || user.permission?('update_material')
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin? || user.permission?('create_material')
      [:name, :name_py, :catalog_id, :min_stock, :price, :unit, :brand, :image_item_ids => [], :vendor_ids => []]
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.super_admin_or_admin? || user.permission?('update_material')
      [:name, :name_py, :catalog_id, :min_stock, :price, :unit, :brand, :image_item_ids => [], :vendor_ids => []]
    else
      []
    end
  end
end
