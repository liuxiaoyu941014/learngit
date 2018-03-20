# csv support
require 'csv'
class Admin::MarketCatalogsController < Admin::BaseController
  before_action :set_market_catalog, only: [:show, :edit, :update, :destroy]

  # GET /admin/market_catalogs
  def index
    authorize MarketCatalog
    @filter_colums = %w(name id)
    @market_catalogs = build_query_filter(MarketCatalog.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@market_catalogs.to_json, filename: "market_catalogs-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@market_catalogs.to_xml, filename: "market_catalogs-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@market_catalogs.as_csv(), filename: "market_catalogs-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/market_catalogs/1
  def show
    authorize @market_catalog
  end

  # GET /admin/market_catalogs/new
  def new
    authorize MarketCatalog
    @market_catalog = MarketCatalog.new
  end

  # GET /admin/market_catalogs/1/edit
  def edit
    authorize @market_catalog
  end

  # POST /admin/market_catalogs
  def create
    authorize MarketCatalog
    @market_catalog = MarketCatalog.new(permitted_attributes(MarketCatalog))

    if @market_catalog.save
      redirect_to admin_market_catalog_path(@market_catalog), notice: "#{MarketCatalog.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/market_catalogs/1
  def update
    authorize @market_catalog
    if @market_catalog.update(permitted_attributes(@market_catalog))
      redirect_to admin_market_catalog_path(@market_catalog), notice: "#{MarketCatalog.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/market_catalogs/1
  def destroy
    authorize @market_catalog
    @market_catalog.destroy
    redirect_to admin_market_catalogs_url, notice: "#{MarketCatalog.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_catalog
      @market_catalog = MarketCatalog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_market_catalog_params
    #       #   params[:admin_market_catalog]
    #       # end
end
