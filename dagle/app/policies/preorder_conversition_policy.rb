class PreorderConversitionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    user.super_admin_or_admin? || user.permission?(:update_preorder_conversition)
  end

  def create?
    user.super_admin_or_admin? || user.permission?(:create_preorder_conversition)
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin? || user.has_role?(:agent) || user.permission?(:create_preorder_conversition)
      [:site_id, :title, :content, :member_id, :member_name, :member_phone, :member_address]
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.super_admin_or_admin? || user.permission?(:update_preorder_conversition)
      [:site_confirm]
    elsif user.has_role?(:agent)
      [:factory_confirm]
    else
      []
    end
  end
end
