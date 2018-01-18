class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private
  def current_user
    @current_user ||= cookies[:auth_token] && User.find_by(auth_token: cookies[:auth_token])
  end

helper_method :current_user
end
