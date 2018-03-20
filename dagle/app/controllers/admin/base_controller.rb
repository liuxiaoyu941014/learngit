class Admin::BaseController < ApplicationController
  before_action :ensure_admin_user!
  after_action :verify_authorized
  acts_as_themeable 'color_admin'

  private

  def ensure_admin_user!
    redirect_to admin_sign_in_url unless current_user && (current_user.super_admin_or_admin? || current_user.permission?(:login_admin))
  end
end
