class Cms::CommentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.super_admin_or_admin? || user.has_role?(:agent)
  end

  def show?
    user.super_admin_or_admin? || user.has_role?(:agent)
  end

  def new?
    user.super_admin_or_admin? || user.has_role?(:agent)
  end

  def create?
    user.super_admin_or_admin? || (user.has_role?(:agent) && record.site.site.try(:user_id) == user.id)
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
    if user.super_admin_or_admin?  || user.has_role?(:agent)
      [:site_id, :contact, :content, :name, :mobile_phone, :tel_phone,:email,:qq,
      :address,:gender,:birth,:hobby,:content2,:content3,:status,:branch,:datetime,:is_published]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
