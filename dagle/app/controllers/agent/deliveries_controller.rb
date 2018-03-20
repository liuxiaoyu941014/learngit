class Agent::DeliveriesController < Agent::BaseController
  before_action :set_delivery, only: [:edit, :update, :destroy]

  def index
    authorize Delivery
    @agent_deliveries = @site.deliveries.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @agent_deliveries }
    end
  end

  def new
    authorize Delivery
    @agent_delivery = @site.deliveries.new(delivery_params)
  end

  def edit
    authorize @agent_delivery
  end

  def create
    authorize Delivery
    @agent_delivery = @site.deliveries.new(permitted_attributes(Delivery))

    respond_to do |format|
      format.html do
        if @agent_delivery.save
          redirect_to agent_deliveries_path, notice: '货运信息创建成功.'
        else
          render :new
        end
      end
      format.json { render json: @agent_delivery }
    end

  end

  def update
    authorize @agent_delivery
    respond_to do |format|
      format.html do
        if @agent_delivery.update(permitted_attributes(@agent_delivery))
          redirect_to agent_deliveries_path, notice: '货运信息更新成功.'
        else
          render :edit
        end
      end
      format.json { render json: @agent_delivery }
    end
  end

  def destroy
    authorize @agent_delivery
    @agent_delivery.destroy
    respond_to do |format|
      format.html { redirect_to agent_deliveries_url, notice: '货运信息删除成功.' }
      format.json { head 200 }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery
      @agent_delivery = @site.deliveries.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def delivery_params
      params[:delivery]
    end
end
