class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def dashboard?
    user.super_admin_or_admin?
  end

  def index?
    user.super_admin_or_admin?
    # record.is_a?(ActiveRecord::Associations::HasManyAssociation) && record.proxy_association.owner
  end

  def show?
    user.super_admin_or_admin? && scope.where(:id => record.id).exists?
  end

  def create?
    user.super_admin_or_admin?
  end

  def new?
    user.super_admin_or_admin?
  end

  def update?
    user.super_admin_or_admin?
  end

  def edit?
    user.super_admin_or_admin?
  end

  def destroy?
    user.super_admin_or_admin?
  end

  def permitted_attributes_for_create
    []
  end

  def permitted_attributes_for_update
    []
  end

  def scope
    Pundit.policy_scope!(user, record.class)
  end

  class Scope
    attr_reader :user, :scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end
    def resolve
      scope
    end
  end
end
