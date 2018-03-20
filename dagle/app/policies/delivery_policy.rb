class DeliveryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def index?
    user.super_admin_or_admin? || user.has_role?(:agent)
  end

  def new?
    index?
  end

  def edit?
    index?
  end

  def create?
    new?
  end

  def update?
    edit?
  end

  def destroy?
    create?
  end

  def permitted_attributes_for_create
    # fail "请在#{__FILE__}中添加params的permit属性"
    if user.has_role?(:admin) || user.has_role?(:agent) || user.premission?('login_desktop')
      [:name, :features, :address, :phone_number, :site_id]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
