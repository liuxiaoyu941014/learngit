class Cms::SitePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.super_admin_or_admin? || user.has_role?(:agent)
  end

  def show?
    return true if user.super_admin_or_admin?
    user.has_role?(:agent) && record.site.try(:user_id) == user.id
  end

  def new?
    user.super_admin_or_admin? || user.has_role?(:agent)
  end

  def create?
    user.super_admin_or_admin? || (user.has_role?(:agent) && record.site.try(:user_id) == user.id)
  end

  def edit?
    create?
  end

  def update?
    edit?
  end

  #只有超级管理员和创建站点的自己本人才能删除CMS站点
  def destroy?
    return true if user.super_admin? || (user.has_role?(:agent) && record.site.try(:user_id) == user.id)
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin? || user.has_role?(:agent)
      [:site_id, :name, :template, :domain, :root_domain, :description, :is_published]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
