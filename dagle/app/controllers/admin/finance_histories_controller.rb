# csv support
require 'csv'
class Admin::FinanceHistoriesController < Admin::BaseController
  before_action :set_finance_history, only: [:show, :edit, :update, :destroy]
  before_action :set_type, only: [:index,:new]
  # GET /admin/finance_histories
  def index
    authorize FinanceHistory
    return redirect_to admin_root_path, alert: "访问的页面不存在" unless @type
    @finance_histories_all = FinanceHistory.all.send(@type)
    if params["daterange"].present?
      date_range = params["daterange"].split(' - ').map(&:strip).map(&:to_date)
      @finance_histories_all = @finance_histories_all.where("operate_date in (?)", date_range[0]..date_range[-1])
    end
    @orders = Order.all
    @material_purchases = MaterialPurchase.all
    if @type == 'in'
      if params[:order_code].present?
        @orders = @orders.where("code like ?", "%#{params[:order_code]}%")
      end
      if params[:site_name].present?
        @orders = @orders.joins(:site).where("sites.title like ?", "%#{params[:site_name]}%")
      end
      @finance_histories_all = @finance_histories_all.where(owner: @orders)
    else
      if params[:purchase_code].present?
        @material_purchases = @material_purchases.where("code like ?", "%#{params[:purchase_code]}%")
      end
      if params[:vendor_name].present?
        @material_purchases = @material_purchases.joins(:vendor).where("items.name like ?", "%#{params[:vendor_name]}%")
      end
      @finance_histories_all = @finance_histories_all.where(owner: @material_purchases)
    end
    @finance_histories = @finance_histories_all.includes(:owner).order("updated_at DESC").page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@finance_histories.to_json, filename: "finance_histories-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@finance_histories.to_xml, filename: "finance_histories-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@finance_histories_all.as_csv(only: [:operate_date, :amount, :note]), filename: "finance_histories-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/finance_histories/1
  def show
    authorize @finance_history
  end

  # GET /admin/finance_histories/new
  def new
    authorize FinanceHistory
    @finance_history = FinanceHistory.new(operate_type: @type)
    if @finance_history.in?
      @finance_history.owner_type = 'Order'
    else
      @finance_history.owner_type = 'MaterialPurchase'
    end
  end

  # POST /admin/finance_histories
  def create
    authorize FinanceHistory
    @finance_history = FinanceHistory.new(permitted_attributes(FinanceHistory).merge(created_by: current_user.id))
    if @finance_history.out?
      @finance_history.owner.paid = @finance_history.owner.paid.to_f + @finance_history.amount
    end
    if @finance_history.save && @finance_history.owner.save
      redirect_to admin_finance_histories_path(type: @finance_history.operate_type), notice: "#{FinanceHistory.model_name.human} 创建成功."
    else
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_finance_history
      @finance_history = FinanceHistory.find(params[:id])
    end

    def set_type
      @type = nil
      if ['in', 'out'].include?(params[:type])
        @type = params[:type]
        @operate_type_name = enum_i18n(FinanceHistory, :operate_type, @type)
      else
        @type = 'in'
      end
    end
    # Only allow a trusted parameter "white list" through.
    # def admin_finance_history_params
    #       #   params.require(:admin_finance_history).permit(policy(@admin_finance_history).permitted_attributes)
    #       # end
end
