class User::WeixinPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes_for_create
    []
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
