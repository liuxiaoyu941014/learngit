# csv support
require 'csv'
class Admin::MaterialManagementHistoriesController < Admin::BaseController

  # GET /admin/material_management_histories
  def index
    authorize MaterialManagementDetail
    @filter_colums = %w(id)
    @admin_material_management_histories = build_query_filter(MaterialManagementDetail.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@admin_material_management_histories.to_json, filename: "admin_material_management_details-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@admin_material_management_histories.to_xml, filename: "admin_material_management_details-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@admin_material_management_histories.as_csv(), filename: "admin_material_management_details-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

end
