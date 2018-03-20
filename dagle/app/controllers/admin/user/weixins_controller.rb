# csv support
require 'csv'
class Admin::User::WeixinsController < Admin::BaseController
  before_action :set_user_weixin, only: [:show]

  # GET /admin/user/weixins
  def index
    authorize User::Weixin
    @filter_colums = %w(id)
    @user_weixins = build_query_filter(User::Weixin.all, only: @filter_colums).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@user_weixins.to_json, filename: "user_weixins-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@user_weixins.to_xml, filename: "user_weixins-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@user_weixins.as_csv(only: []), filename: "user_weixins-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/user/weixins/1
  def show
    authorize @user_weixin
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_weixin
      @user_weixin = User::Weixin.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_user_weixin_params
    #       #   params.require(:admin_user_weixin).permit(policy(@admin_user_weixin).permitted_attributes)
    #       # end
end
