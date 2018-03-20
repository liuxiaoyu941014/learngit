class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.super_admin_or_admin?
  end

  def show?
    user.super_admin_or_admin? || user.id == record.id
  end

  def new?
    user.super_admin_or_admin?
  end

  def create?
    new?
  end

  def edit?
    return true if user.id == record.id # 自己当然能够修改自己的信息
    return true if user.has_role?(:super_admin) # 超级管理员能修改任何人的信息
    return false if user.has_role?(:admin, :any) && record.super_admin_or_admin? # 管理员不能修改另外一个管理员的信息，当然，更不能修改超级管理员的信息
    true
  end

  def update?
    edit?
  end

  def destroy?
    return false if record.id == User::MAIN_ID
    return false if user.id == record.id # 自己不能删除自己的信息
    return true if user.has_role?(:super_admin) # 超级管理员能删除任何人的信息
    return false if record.super_admin_or_admin? # 管理员不能删除另外一个管理员的信息，当然，更不能删除超级管理员的信息
    true
  end

  def edit_permission?
    return false if user.id == record.id # 自己不能修改自己的权限
    return true if user.has_role?(:super_admin) # 超级管理员能修改任何人的权限
    return false if user.has_role?(:admin, :any) && record.super_admin_or_admin? # 管理员不能修改另外一个管理员的权限，更不能修改超级管理员的权限
    true
  end

  def update_permission?
    edit_permission?
  end

  def impersonate?
    user.id != record.id && user.super_admin_or_admin? && !record.has_role?(:super_admin)
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin?
      [:mobile_phone, :nickname, :email, :password, :password_confirmation, :role_ids => []]
    else
      []
    end
  end

  def permitted_attributes_for_update
    if user.super_admin_or_admin?
      if record.id == User::MAIN_ID
        [:mobile_phone, :nickname, :password, :password_confirmation, :email]
      else
        [:mobile_phone, :nickname, :password, :password_confirmation, :email, :role_ids => []]
      end
    elsif user.id == record.id
      [:nickname, :email, :password, :password_confirmation]
    else
      []
    end
  end

end
