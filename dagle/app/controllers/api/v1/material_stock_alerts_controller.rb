# 物料仓库预警

class Api::V1::MaterialStockAlertsController < Api::V1::BaseController
  before_action :authenticate!

  # 获得物料仓库预警列表
  # @param [Integer] page 页码
  # @param [Integer] page_size 每页显示数据
  # @return [JSON]
  def index
    # authorize MaterialStockAlert
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    material_stock_alerts = params['status'].present? ? MaterialStockAlert.where(status: params["status"]) : MaterialStockAlert.all
    material_stock_alerts = material_stock_alerts.joins(:material).where("items.name_py like :key OR items.name like :key", {key: ['%',params['search_content'].upcase, '%'].join}) unless params['search_content'].blank?
    material_stock_alerts =  material_stock_alerts.includes(:material).order(created_at: :desc).page(params[:page] || 1).per(page_size)
    render json: {
      material_stock_alerts: material_stock_alert_json(material_stock_alerts),
      page_size: page_size,
      current_page: material_stock_alerts.current_page,
      total_pages: material_stock_alerts.total_pages,
      total_count: material_stock_alerts.total_count
    }
  end


  private

  def material_stock_alert_json(material_stock_alerts)
    material_stock_alerts.as_json(
      only: %w(id title body status),
      include: {material: {only: %w(id name name_py)}}
    )
  end

end
