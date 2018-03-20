# csv support
require 'csv'
class Admin::MarketTemplatesController < Admin::BaseController
  before_action :set_market_template, only: [:show, :edit, :update, :destroy]

  # GET /admin/market_templates
  def index
    authorize MarketTemplate
    @filter_colums = %w(id)
    @market_templates = build_query_filter(MarketTemplate.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@market_templates.to_json, filename: "market_templates-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@market_templates.to_xml, filename: "market_templates-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@market_templates.as_csv(), filename: "market_templates-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/market_templates/1
  def show
    authorize @market_template
  end

  # GET /admin/market_templates/new
  def new
    authorize MarketTemplate
    @market_template = MarketTemplate.new
  end

  # GET /admin/market_templates/1/edit
  def edit
    authorize @market_template
  end

  # POST /admin/market_templates
  def create
    authorize MarketTemplate
    @market_template = MarketTemplate.new(permitted_attributes(MarketTemplate))
    if @market_template.save
      redirect_to admin_market_template_path(@market_template), notice: "#{MarketTemplate.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/market_templates/1
  def update
    authorize @market_template
    if @market_template.update(permitted_attributes(@market_template))
      redirect_to admin_market_template_path(@market_template), notice: "#{MarketTemplate.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/market_templates/1
  def destroy
    authorize @market_template
    @market_template.destroy
    redirect_to admin_market_templates_url, notice: "#{MarketTemplate.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_market_template
      @market_template = MarketTemplate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_market_template_params
    #       #   params[:admin_market_template]
    #       # end
end
