class ApplicationController < ActionController::Base
  # include helpers
  helper FontAwesome::Rails::IconHelper
  include EnumI18nHelper
  helper :enum_i18n

  include Pundit
  include QueryFilterControllerConcern
  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :not_found!
  impersonates :user

  #render 404 error
  def not_found!
    raise ActionController::RoutingError.new('Not Found')
  end
  #detect if a mobile device
  def mobile_device?
    !!(request.user_agent =~ /Mobile|webOS/i)
  end

  def wechat_device?
    !!(request.user_agent =~ /MicroMessenger/i)
  end
  helper_method :mobile_device?, :wechat_device?

  private
  def user_not_authorized
    flash[:alert] = "没有访问权限"
    redirect_to(request.referrer || root_path)
  end
end
