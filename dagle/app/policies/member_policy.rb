class MemberPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.super_admin_or_admin? || user.has_role?(:agent)
  end

  def show?
    user.super_admin_or_admin? || (user.has_role?(:agent) && record.site.try(:user_id) == user.id)
  end

  def new?
    user.super_admin_or_admin? || user.has_role?(:agent)
  end

  def create?
    user.super_admin_or_admin? || (user.has_role?(:agent) && record.site.try(:user_id) == user.id) || user.permission?('create_member')
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

  def member_create?
    true
  end

  def all?
    user.super_admin_or_admin?
  end

  def permitted_attributes_for_create
    if user.has_role?(:admin) || user.has_role?(:agent)
      [:user_id, :name, :qq, :email, :birth, :mobile_phone, :tel_phone, :wechat, :firm, :address, :note, :typo, :from, :owned, :features]
    else
      [:user_id, :name, :qq, :email, :birth, :mobile_phone, :tel_phone, :wechat, :firm, :address, :note, :typo, :from, :owned, :features]
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
