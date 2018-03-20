class AppSettingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.has_role? :super_admin
  end

  def new?
    create?
  end

  def update?
    edit?
  end

  def edit?
    user.super_admin_or_admin?
  end

  def destroy?
    create?
  end

  def used?
    edit?
  end

  def edit_banner?
    edit?
  end

  def permitted_attributes_for_create
    if user.has_role? :super_admin
      [:name, :key_word, :article_share_url_pattern, :site_share_url_pattern, :product_share_url_pattern, :system_rooms, :service_banners, :main_banners, :app_version_message, :active, :auto_deliver_days, :auto_cancel_hours]
    elsif user.has_role? :admin
      [:service_banners, :main_banners, :active, :auto_deliver_days, :auto_cancel_hours]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
