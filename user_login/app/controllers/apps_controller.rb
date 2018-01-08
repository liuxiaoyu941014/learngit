class AppsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = '注册成功,请登录'
     redirect_to new_session_path
    else
      render action: :new
    end
  end
  private
  def user_params
   params.require(:user).permit(:name, :password, :password_confirmation)
  end
end
