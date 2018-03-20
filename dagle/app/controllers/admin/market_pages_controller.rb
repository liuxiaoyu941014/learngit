# csv support
require 'csv'
class Admin::MarketPagesController < Admin::BaseController
  before_action :set_market_page, only: [:show, :edit, :update, :destroy]

  def dashboard
    authorize MarketPage
  end
  # GET /admin/market_pages
  def index
    authorize MarketPage
    @filter_colums = %w(id)
    @market_pages = build_query_filter(MarketPage.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@market_pages.to_json, filename: "market_pages-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@market_pages.to_xml, filename: "market_pages-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@market_pages.as_csv(), filename: "market_pages-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/market_pages/1
  def show
    authorize @market_page
  end

  # GET /admin/market_pages/new
  def new
    authorize MarketPage
    @market_page = MarketPage.new
  end

  # GET /admin/market_pages/1/edit
  def edit
    authorize @market_page
  end

  # POST /admin/market_pages
  def create
    authorize MarketPage
    @market_page = MarketPage.new(permitted_attributes(MarketPage))

    if @market_page.save
      redirect_to admin_market_page_path(@market_page), notice: "#{MarketPage.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/market_pages/1
  def update
    authorize @market_page
    if @market_page.update(permitted_attributes(@market_page))
      redirect_to admin_market_page_path(@market_page), notice: "#{MarketPage.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/market_pages/1
  def destroy
    authorize @market_page
    @market_page.destroy
    redirect_to admin_market_pages_url, notice: "#{MarketPage.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_page
      @market_page = MarketPage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_market_page_params
    #       #   params[:admin_market_page]
    #       # end
end
