class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  def index
    authorize! :show, User
    @users = User.all.includes(:roles)
  end

  def show
    authorize! :show, @user
  end

  def new
    authorize! :create, User
    @user = User.new
  end

  def edit
    authorize! :update, @user
  end

  def create
    authorize! :create, User
    @user = User.new(user_params)
    if @user.save
      redirect_to @user, notice: t_flash('create.notice')
    else
      render :new
    end
  end

  def update
    authorize! :update, @user
    if @user.update(user_params)
      redirect_to @user, notice: t_flash('update.notice')
    else
      render :edit
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    authorize! :destroy, @user
    if @user.destroy
      redirect_to users_url, notice: t_flash('destroy.notice')
    else
      redirect_back fallback_location: :index, alert: t_flash('destroy.alert', reason: @user.errors.full_messages.join(', '))
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      # params.fetch(:user, {})
      attrs = params.require(:user).permit(:email, :mobile_phone, :name, :username, :password, :password_confirmation, role_ids: [])
      if attrs[:password].blank? && attrs[:password_confirmation].blank?
        attrs.delete(:password)
        attrs.delete(:password_confirmation)
      end
      attrs
    end
end
