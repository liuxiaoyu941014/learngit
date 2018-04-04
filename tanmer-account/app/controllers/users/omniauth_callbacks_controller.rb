class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include SessionsHelper
  skip_before_action :ensure_login!
  skip_authorization_check
  def gitlab
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      @user.sso_login!
      sign_in @user, :event => :authentication #this will throw if @user is not activated
      back_url = request.env["omniauth.origin"] || root_url
      back_url = root_url if back_url == login_url
      # app = Doorkeeper::Application.find_by(uid: request.env["omniauth.params"]['appid'])
      # token = generate_jwt_token(app, @user)
      # back_url = "#{back_url}#{ back_url =~ /\?/ ? '&' : '?' }tanmer_auth_token=#{token}"
      redirect_to back_url
      set_flash_message(:notice, :success, :kind => "Gitlab") if is_navigational_format?
    else
      session["devise.gitlab_data"] = request.env["omniauth.auth"]
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
