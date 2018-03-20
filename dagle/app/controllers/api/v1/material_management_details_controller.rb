# 物料管理

class Api::V1::MaterialManagementDetailsController < Api::V1::BaseController
  before_action :authenticate!

  # 获得物料出库／入库列表
  # @param [String] operate_type 操作类型(input/ouput)
  # @param [Integer] page 页码
  # @param [Integer] page_size 每页显示数据
  # @return [JSON]
  def index
    # authorize MaterialManagement
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    operate_type = set_operate_type
    conditions = {}
    conditions['operate_type'] = operate_type
    if params["date_range"].present? && params["date_range"].many?
      if params['date_range'][0] == params['date_range'][1]
        conditions['operate_date'] = params["date_range"][0].to_date unless params["date_range"][0] == 'NaN'
      else
        conditions['operate_date'] =  params['date_range'][0].to_date..params['date_range'][1].to_date
      end
    end
    material_management_details = MaterialManagementDetail.joins(:material_management, :material).includes(:material, material_management: [:material_warehouse]).where(material_managements: conditions)
    material_management_details = material_management_details.where("items.name_py like :key OR items.name like :key", {key: ['%',params['search_content'].upcase, '%'].join}) if params['search_content'].present?
    material_management_details = material_management_details.order("material_management_details.created_at desc").page(params[:page] || 1).per(page_size)
    render json: {
      material_management_details: material_management_detail_json(material_management_details),
      page_size: page_size,
      current_page: material_management_details.current_page,
      total_pages: material_management_details.total_pages,
      total_count: material_management_details.total_count
    }
  end

  private
  def set_operate_type
    if ['input', 'output'].include?(params["operate_type"])
      MaterialManagement.operate_types[params['operate_type']]
    else
      -1
    end
  end

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
