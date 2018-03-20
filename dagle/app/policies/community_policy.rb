class CommunityPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.super_admin_or_admin? || user.has_role?(:worker)
  end

  def new?
    user.super_admin_or_admin? || user.permission?(:communities_insert)
  end

  def create?
    new?
  end

  def edit?
    user.super_admin_or_admin? || user.permission?(:communities_update)
  end

  def update?
    edit?
  end

  def show?
    index?
  end

  def destroy?
    user.super_admin_or_admin? || user.permission?(:communities_delete)
  end

  def permitted_attributes_for_create
    # fail "请在#{__FILE__}中添加params的permit属性"
    if user.has_role? :admin
      [:name, :address_line, :owned_by, :contact_info, :note, :is_published]
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.has_role? :admin
      [:name, :address_line, :lat, :lng, :owned_by, :contact_info, :note, :is_published]
    else
      []
    end
  end
end
