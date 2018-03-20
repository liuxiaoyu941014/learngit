class ProducePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def need_export?
    index?
  end

  def create?
    user.super_admin_or_admin? || user.permission?(:create_produce)
  end

  def update?
    user.super_admin_or_admin? || user.permission?(:update_produce)
  end

  def destroy?
    user.super_admin_or_admin? || user.permission?(:destroy_produce)
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin? || user.permission?(:create_produce)
      [:assignee_id, :status]
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.super_admin_or_admin? || user.permission?(:update_produce)
      [:status]
    else
      []
    end
  end
end
