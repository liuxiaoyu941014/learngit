# csv support
require 'csv'
class Admin::DeliveriesController < Admin::BaseController
  before_action :set_site, only: [:create]
  before_action :set_delivery, only: [:edit, :update, :destroy]

  # GET /admin/deliveries
  def index
    authorize Delivery
    @filter_colums = %w(name)
    @deliveries = build_query_filter(Delivery.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@deliveries.to_json, filename: "deliveries-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@deliveries.to_xml, filename: "deliveries-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@deliveries.as_csv(), filename: "deliveries-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/deliveries/new
  def new
    authorize Delivery
    @delivery = Delivery.new
  end

  # GET /admin/deliveries/1/edit
  def edit
    authorize @delivery
  end

  # POST /admin/deliveries
  def create
    authorize Delivery
    @delivery = @site.deliveries.new(permitted_attributes(Delivery))

    if @delivery.save
      redirect_to admin_deliveries_path, notice: "#{Delivery.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/deliveries/1
  def update
    authorize @delivery
    if @delivery.update(permitted_attributes(@delivery))
      redirect_to admin_deliveries_path, notice: "#{Delivery.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/deliveries/1
  def destroy
    authorize @delivery
    @delivery.destroy
    redirect_to admin_deliveries_url, notice: "#{Delivery.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    def set_site
      @site = Site.find(Site::MAIN_ID)
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_delivery_params
    #       #   params[:admin_delivery]
    #       # end
end
