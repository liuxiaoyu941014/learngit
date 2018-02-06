class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def configure_permitted_parametersod_name
    devise_parameter_sanitizer.permit(:sign_in) {|u|u.permit(:email, :username, :password, :remember_me)}
    devise_parameter_sanitizer.permit(:sign_up) {|u|u.permit(:email, :username, :password,:password_confirmation)}
end

# def configure_permitted_parametersod_name
#   devise_parameter_sanitizer.permit(:sign_in) {|u| u.permit(:signin, :password, :remember_me)}
#   devise_parameter_sanitizer.permit(:sign_up) {|u|
#   u.permit(:email, :username, :password, :password_confirmation)}
# end


  before_action :configure_permitted_parametersod_name, if: :devise_controller?

  # def create
  #   # name = params[:name]
  #   # password = params[:password_digest]
  #   @model = Model.find_by_email(params[:email])
  #   # @user = User.find_by(name: params[:session][:name], password_digest: params[:session][:password_digest])
  #   if @model && @@model.authenticate(params[:password])
  #   session[:current_model_id] = @model.id
  #   flash[:notice] = '登录成功'
  #   redirect_to root_path
  #   else
  #   flash[:notice] = "用户名或者密码不正确" 
  #   render action: :new
  #   end
  # end
end
