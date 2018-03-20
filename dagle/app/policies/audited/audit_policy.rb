class Audited::AuditPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end
  def statistics?
    user.super_admin_or_admin?
  end
  
end
