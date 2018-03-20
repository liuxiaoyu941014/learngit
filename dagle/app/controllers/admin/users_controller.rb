class Admin::UsersController < Admin::BaseController
  before_action :set_admin_user, only: [:update, :edit, :destroy, :show, :edit_permission, :update_permission]

  def dashboard
    authorize User
  end

  def index
    authorize User
    @admin_users = User.all
    @admin_users = @admin_users.joins(:roles).where("roles.id = ?", params[:role_id])if params[:role_id]
    @admin_users = @admin_users.where("nickname like ?", "%#{params['q']}%") if params["q"].present?
    if params[:search] && params[:search][:keywords]
      @admin_users = @admin_users.joins(:mobile).where("nickname like :key OR email like :key OR user_mobiles.phone_number like :key", {key: "%#{params[:search][:keywords]}%"})
    end
    @admin_users = @admin_users.includes(:roles, :mobile).order(updated_at: :desc).page params[:page]
    respond_to do |format|
      format.html
      format.json { render json: {:results => @admin_users.select(:id, :nickname), :total => @admin_users.size} }
    end
  end

  def new
    authorize User
    @admin_user = User.new
  end

  def create
    authorize User
    flag, @admin_user = User::Create.(permitted_attributes(User), current_user)
    if flag
      redirect_to edit_admin_user_url(@admin_user), notice: '用户创建成功！'
    else
      render :new
    end
  end

  def edit
    authorize @admin_user
  end

  def update
    authorize @admin_user
    flag, @admin_user =  User::Update.(@admin_user, permitted_attributes(@admin_user), current_user)
    if flag
      redirect_to edit_admin_user_url(@admin_user), notice: '用户更新成功！'
    else
      render :edit
    end
  end

  def show
    authorize @admin_user
  end

  def destroy
    authorize @admin_user
    flag, @admin_user =  User::Destroy.(@admin_user)
    respond_to do |format|
      format.html { redirect_to admin_users_path, notice: '用户删除成功！' }
      format.json { head :no_content }
    end
  end

  def edit_permission
    authorize @admin_user
    sort_permissions
    @chekced_permissions = @admin_user.permission_ids
  end

  def update_permission
    authorize @admin_user
    @admin_user.permission_ids = params[:permission_ids].try{map(&:to_i).uniq}
    if @admin_user.save
      redirect_to admin_users_path(@product), notice: '权限修改成功.'
    else
      render json: {status: 'failed', message: '权限修改出错.'}
    end
  end

  private

  def set_admin_user
    @admin_user = User.find_by(id: params[:id])
  end

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

end
