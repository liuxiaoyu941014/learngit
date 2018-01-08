class SessionsController < ApplicationController
  def new
  end

  # def create
  #   user = User.find_by(name: user_params[:name]).try(:authenticate, user_params[:password])
  #   if user 
  #     render plain:sprintf("welcome, %s!", user.name)
  #    else
  #     flash.now[:login_error] = "invalid username or password"
  #     render "new"
  #    end
  # end
  def create
    # name = params[:name]
    # password = params[:password_digest]
    @user = User.find_by_name(params[:name])
    # @user = User.find_by(name: params[:session][:name], password_digest: params[:session][:password_digest])
    if @user && @user.authenticate(params[:password])
    session[:current_user_id] = @user.id
    flash[:notice] = '登录成功'
    redirect_to root_path
    else
    flash[:notice] = "用户名或者密码不正确" 
    render action: :new
    end 
    end
    def destroy
      @_current_user =session[:current_user_id] = nil
      flash[:notice] = "退出成功"
      redirect_to root_path
      end
  # private
  # def user_params
  #  params.require(:user).permit(:name, :password)
  # end
end
