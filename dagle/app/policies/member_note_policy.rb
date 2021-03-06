class MemberNotePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.super_admin_or_admin? || user.has_role?(:agent)
  end

  def show?
    user.super_admin_or_admin? || (user.has_role?(:agent) && record.member.site.try(:user_id) == user.id)
  end

  def new?
    user.super_admin_or_admin? || user.has_role?(:agent)
  end

  def create?
    user.super_admin_or_admin? || (user.has_role?(:agent) && record.member.site.try(:user_id) == user.id)
  end

  def edit?
    create?
  end

  def update?
    edit?
  end

  def destroy?
    create?
  end

  def permitted_attributes_for_create
    if user.has_role?(:admin) || user.has_role?(:agent)
      [:user_id, :member_id, :message]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
