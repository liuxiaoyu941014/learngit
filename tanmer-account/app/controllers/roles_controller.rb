class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def index
    authorize! :show, Role
    @roles = Role.all
  end

  def show
    authorize! :show, @role
  end

  def new
    authorize! :create, Role
    @role = Role.new
  end

  def edit
    authorize! :update, @role
  end

  def create
    authorize! :create, Role
    @role = Role.new(role_params)
    if @role.save
      redirect_to @role, notice: t_flash('create.notice')
    else
      render :new
    end
  end

  def update
    authorize! :update, @role
    if @role.update(role_params)
      redirect_to @role, notice: t_flash('update.notice')
    else
      render :edit
    end
  end

  def destroy
    authorize! :destroy, @role
    if @role.destroy
      redirect_to roles_url, notice: t_flash('destroy.notice')
    else
      redirect_back fallback_location: :index, alert: t_flash('destroy.alert', reason: @role.errors.full_messages.join(', '))
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:name, :description, permission_ids: [])
    end
end
