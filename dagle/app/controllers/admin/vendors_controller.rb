# csv support
require 'csv'
class Admin::VendorsController < Admin::BaseController
  before_action :set_vendor, only: [:show, :edit, :update, :destroy]

  # GET /admin/vendors
  def index
    authorize Vendor
    @filter_colums = %w(id)
    @vendors = build_query_filter(Vendor.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@vendors.to_json, filename: "vendors-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@vendors.to_xml, filename: "vendors-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@vendors.as_csv(), filename: "vendors-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/vendors/1
  def show
    authorize @vendor
  end

  # GET /admin/vendors/new
  def new
    authorize Vendor
    @vendor = Vendor.new
  end

  # GET /admin/vendors/1/edit
  def edit
    authorize @vendor
  end

  # POST /admin/vendors
  def create
    authorize Vendor
    @vendor = Vendor.new(permitted_attributes(Vendor))

    if @vendor.save
      redirect_to admin_vendor_path(@vendor), notice: "#{Vendor.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/vendors/1
  def update
    authorize @vendor
    if @vendor.update(permitted_attributes(@vendor))
      redirect_to admin_vendor_path(@vendor), notice: "#{Vendor.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/vendors/1
  def destroy
    authorize @vendor
    @vendor.destroy
    redirect_to admin_vendors_url, notice: "#{Vendor.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vendor
      @vendor = Vendor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_vendor_params
    #       #   params.require(:admin_vendor).permit(policy(@admin_vendor).permitted_attributes)
    #       # end
end
