class ApplicationController < ThemeableController
  include THelper
  include ApplicationHelper

  protect_from_forgery with: :exception
  before_action :ensure_login!
  check_authorization
  layout 'application'

  private

  def ensure_login!
    # catch(:warden) { authenticate_user! }
    # redirect_to login_path unless signed_in?
    redirect_to login_path unless signed_in?
  end

  def after_sign_out_path_for(resource_or_scope)
    request.referer ? request.referer : super
  end
end
