# csv support
require 'csv'
class Admin::AgentPlansController < Admin::BaseController
  before_action :set_agent_plan, only: [:show, :edit, :update, :destroy]
  before_action :set_agent_plan_price, only: [:create, :update]
  # GET /admin/agent_plans
  def index
    # authorize AgentPlan
    authorize Product
    @filter_colums = %w(id)
    catalog_id = ProductCatalog.find_by(name: '商家套餐').try(:id)
    @agent_plans = build_query_filter(Product.where(catalog_id: catalog_id), only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@agent_plans.to_json, filename: "agent_plans-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@agent_plans.to_xml, filename: "agent_plans-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@agent_plans.as_csv(), filename: "agent_plans-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/agent_plans/1
  def show
    authorize @agent_plan
  end

  # GET /admin/agent_plans/new
  def new
    # authorize AgentPlan
    authorize Product
    @agent_plan = Product.new
    # @agent_plan = AgentPlan.new
  end

  # GET /admin/agent_plans/1/edit
  def edit
    authorize @agent_plan
  end

  # POST /admin/agent_plans
  def create
    # authorize AgentPlan
    authorize Product
    main_site = Site.find_by(id: Site::MAIN_ID)
    catalog = ProductCatalog.find_or_create_by(name: '商家套餐')
    @agent_plan = main_site.products.new(permitted_attributes(Product))
    @agent_plan.catalog = catalog
    if @agent_plan.save
      redirect_to admin_agent_plan_path(@agent_plan), notice: "商家套餐创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/agent_plans/1
  def update
    authorize @agent_plan
    if @agent_plan.update(permitted_attributes(@agent_plan))
      redirect_to admin_agent_plan_path(@agent_plan), notice: "商家套餐更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/agent_plans/1
  def destroy
    authorize @agent_plan
    @agent_plan.destroy
    redirect_to admin_agent_plans_url, notice: "商家套餐删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_agent_plan
      @agent_plan = Product.find(params[:id])
    end

    def set_agent_plan_price
      params[:product][:price] = params[:product][:price].to_f * 100 unless params[:product][:price].blank?
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_agent_plan_params
    #       #   params.require(:admin_agent_plan).permit(policy(@admin_agent_plan).permitted_attributes)
    #       # end
end
