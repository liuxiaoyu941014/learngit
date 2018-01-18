class UsersController < ApplicationController
  def index 
    
  end
  def new
    @user=User.new
  end
  def create
    user = User.new(user_params)
    user.save
    cookies[:auth_token] = user.auth_token #用户注册之后可以直接登进去
    redirect_to :root
  end
  def sign_in
    user = User.find_by_name(params[:name])
    if user && user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to :root
    else 
      redirect_to :login
    end
  end
  def logout
    cookies.delete :auth_token  #还可以写成cookies.delete(:auth_token)
    flash[:notice] = "you have successfully logged out"
    redirect_to :root
  end
  
  private
  def user_params
    params.require(:user).permit!
  end
end
