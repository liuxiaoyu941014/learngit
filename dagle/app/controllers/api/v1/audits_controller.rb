# 操作记录

class Api::V1::AuditsController < Api::V1::BaseController
  before_action :authenticate!

  def index
    # authorize Audit
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    conditions = {}
    conditions['action'] = params["actionValue"] if params["actionValue"].present?
    if params["itemValue"].present?
      if ['Material', 'Vendor', 'MaterialWarehouse'].include?(params["itemValue"])
        conditions['auditable_id'] = eval(params["itemValue"]).all.map(&:id)
        conditions['auditable_type'] = "Item"
      else
        conditions['auditable_type'] = params["itemValue"]
      end
    end
    if params["dateRange"].present? && params["dateRange"].many?
      if params['dateRange'][0] == params['dateRange'][1]
        conditions['created_at'] = Time.at(params["dateRange"][0].to_i).to_date.beginning_of_day..Time.at(params["dateRange"][0].to_i).to_date.end_of_day unless params["dateRange"][0] == 'NaN'
      else
        conditions['created_at'] =  Time.at(params['dateRange'][0].to_i).to_datetime..Time.at(params['dateRange'][1].to_i).to_datetime
      end
    end
    audits = Audit.where(conditions).order(created_at: :desc).page(params[:page] || 1).per(page_size)
    render json: {
      audits: audits.as_json(only: %w(id action audited_changes created_at auditable_type auditable_id), methods: %w(user)),
      page_size: page_size,
      current_page: audits.current_page,
      total_pages: audits.total_pages,
      total_count: audits.total_count
    }
  end

end
