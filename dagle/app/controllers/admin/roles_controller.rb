class Admin::RolesController < Admin::BaseController
  before_action :set_role, only: [:edit, :update, :destroy, :edit_permission, :update_permission]

  def index
    authorize Role
    @admin_roles = Role.all.order(updated_at: :desc).page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: {admin_roles: @admin_roles.as_json(only: [:id], methods: [:role_name])} }
    end
  end

  # GET /admin/members/1/edit
  def edit
    authorize @role
  end

  def update
    authorize @role
    respond_to do |format|
      format.html do
        if @role.update(permitted_attributes(@role))
          redirect_to admin_roles_path, notice: ' 更新成功.'
        else
          render :edit
        end
      end
      format.json { render json: @role }
    end
  end

  def destroy
    authorize @role
    @role.destroy
    respond_to do |format|
      format.html { redirect_to admin_roles_path, notice: ' 删除成功.' }
      format.json { head 200 }
    end
  end

  def edit_permission
    authorize @role
    sort_permissions
    @chekced_permissions = @role.permission_ids
  end

  def update_permission
    authorize @role
    @role.permission_ids = params[:permission_ids].try{map(&:to_i).uniq}
    if @role.save
      redirect_to admin_roles_path(@product), notice: '权限修改成功.'
    else
      render json: {status: 'failed', message: '权限修改出错.'}
    end
  end

  private
    def sort_permissions
      permission_hash = {}
      checked_status = {}
      Permission.all.each do |permission|
        if permission_hash[permission.group_name].blank?
          permission_hash[permission.group_name] = []
          checked_status[permission.group_name] = false
        end
        permission_hash[permission.group_name] << permission.as_json(only: [:id, :name, :group_name])
      end
      @permissions = permission_hash
      @checked_status = checked_status
    end

    def set_role
      @role = Role.find(params[:id])
    end
end
