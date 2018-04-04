class Api::V1::PermissionsController < Api::V1::BaseController
  skip_before_action :doorkeeper_authorize!
  before_action :verify_signature!

  def index
    render json: permission_json(signature_app.permissions)
  end

  def update
    permission = signature_app.permissions.find(params[:id])
    permission.assign_attributes(permission_params)
    if permission.save
      render json: permission_json(permission)
    else
      render json: { error: permission.errors }
    end
  end

  def destroy
    permission = signature_app.permissions.find(params[:id])
    if permission.destroy
      render json: { success: true }
    else
      render json: { error: permission.errors }
    end
  end

  def create
    permission = signature_app.permissions.new(permission_params)
    if permission.save
      Role.sync_admin_permissions!
      render json: permission_json(permission)
    else
      render json: permission.errors.as_json
    end
  end

  private

  def permission_json(perm)
    perm.as_json(except: [:app_id], methods: [:friendly_name])
  end

  def permission_params
    params.require(:permission).permit(:name, :group_name, :subject_class, :subject_id, :action, :description)
  end
end
