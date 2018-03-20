# csv support
require 'csv'
class Admin::BannersController < Admin::BaseController
  before_action :set_banner, only: [:show, :edit, :update, :destroy]

  # GET /admin/banners
  def index
    authorize Banner
    @filter_colums = %w(id)
    @banners = build_query_filter(Banner.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@banners.to_json, filename: "banners-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@banners.to_xml, filename: "banners-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@banners.as_csv(), filename: "banners-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/banners/1
  def show
    authorize @banner
  end

  # GET /admin/banners/new
  def new
    authorize Banner
    @banner = Banner.new
  end

  # GET /admin/banners/1/edit
  def edit
    authorize @banner
  end

  # POST /admin/banners
  def create
    authorize Banner
    @banner = Banner.new(permitted_attributes(Banner))

    if @banner.save
      redirect_to admin_banner_path(@banner), notice: "#{Banner.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/banners/1
  def update
    authorize @banner
    if @banner.update(permitted_attributes(@banner))
      redirect_to admin_banner_path(@banner), notice: "#{Banner.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/banners/1
  def destroy
    authorize @banner
    @banner.destroy
    redirect_to admin_banners_url, notice: "#{Banner.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_banner
      @banner = Banner.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_banner_params
    #       #   params[:admin_banner]
    #       # end
end
