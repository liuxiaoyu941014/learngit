class Agent::MarketPagesController < Agent::BaseController
  before_action :set_market_templates
  before_action :set_market_page, only: [:show, :edit, :update, :destroy, :preview]
  layout :resolve_layout

  def index
    authorize MarketPage
    @market_pages = @site.market_pages.order("id desc").page(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @market_pages }
    end
  end

  def show
    authorize @market_page
    resource = @market_page.sales_distribution_resources.first
    @share_path = URI(request.scheme + "://" + request.host + ":" + request.port.to_s).merge(resource.share_path).to_s
    respond_to do |format|
      format.html
      format.json { render json: @market_page }
    end
  end

  def new
    authorize MarketPage
    @market_template = MarketTemplate.find(params[:template_id]) if params[:template_id]
    @market_page = MarketPage.new(market_page_params)
  end

  def edit
    authorize @market_page
    @market_template = @market_page.market_template
  end

  def create
    @market_page = MarketPage.new(permitted_attributes(MarketPage))
    @market_page.site_id = @site.id
    @market_page.features = params[:mpage]
    authorize @market_page
    respond_to do |format|
      format.html do
        if @market_page.save!
          resource = SalesDistribution::Resource.find_or_create_by(
            type_name: '营销活动',
            user: current_user,
            url: agent_frontend_market_page_path(@site, @market_page),
            object: @market_page
          )
          redirect_to agent_market_page_path(@market_page), notice: '创建成功.'
        else
          render :new
        end
      end
      format.json { render json: @market_page }
    end

  end

  def update
    authorize @market_page
    @market_page.features = params[:mpage]

    respond_to do |format|
      format.html do
        if @market_page.update(permitted_attributes(@market_page))
          redirect_to agent_market_page_path(@market_page), notice: '更新成功.'
        else
          render :edit
        end
      end
      format.json { render json: @market_page }
    end
  end

  def destroy
    authorize @market_page
    @market_page.destroy
    respond_to do |format|
      format.html { redirect_to agent_market_pages_url, notice: '删除成功.' }
      format.json { head 200 }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_page
      @market_page = MarketPage.find(params[:id])
    end

    def set_market_templates
      @market_templates = MarketTemplate.where(is_published: true)
    end

    # Only allow a trusted parameter "white list" through.
    def market_page_params
      params[:market_page]
    end

    def resolve_layout
       case action_name
       when "preview"
         false
       else
         "agent"
       end
     end
end
