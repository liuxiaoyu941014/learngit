class TaskPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.super_admin_or_admin? || user.permission?('create_produce')
  end

  def update?
    user.super_admin_or_admin? || user.permission?('update_produce')
  end

  def destroy?
    user.super_admin_or_admin? || user.permission?('destroy_produce')
  end

  def permitted_attributes_for_create
    # fail "请在#{__FILE__}中添加params的permit属性"
    if user.super_admin_or_admin? || user.permission?('create_produce')
      [:status, :site_id, :title, :description, :assignee_id, :ordinal, :task_type_id]
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.super_admin_or_admin? || user.permission?('update_produce')
      [:status, :title, :description, :assignee_id, :ordinal]
    else
      []
    end
  end
end
