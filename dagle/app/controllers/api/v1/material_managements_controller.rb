# 物料管理

class Api::V1::MaterialManagementsController < Api::V1::BaseController
  before_action :authenticate!

  def create
    authorize MaterialManagement
    flag, material_management = MaterialManagement::Create.(permitted_attributes(MaterialManagement).merge({created_by: current_user.nickname}))
    if flag
      render json: {status: 'ok', material_management_details: material_management_detail_json(material_management.material_management_details)}
    else
      render json: {status: 'failed', error_message:  material_management.errors.full_messages.join(', ')}
    end
  end

  private

  def material_management_detail_json(material_management_details)
    material_management_details.as_json(
      only: %w(id number price),
      include: {
        material_management: { 
          only: %w(id operate_date operate_type note created_by order_code),
          include: {material_warehouse: {only: %w(id name)}}
        },
        material: {only: %w(id name), methods: %w(price)}
      }
    )
  end

end
