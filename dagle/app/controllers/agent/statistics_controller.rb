class Agent::StatisticsController < Agent::BaseController
  # before_action :set_agent_statistic, only: [:show, :edit, :update, :destroy]

  def index
    # authorize Agent::Statistic
    # @agent_statistics = Agent::Statistic.all.page(params[:page])
    # respond_to do |format|
    #   format.html
    #   format.json { render json: @agent_statistics }
    # end
  end

  # def show
  #   authorize @agent_statistic
  #   respond_to do |format|
  #     format.html
  #     format.json { render json: @agent_statistic }
  #   end
  # end
  #
  # def new
  #   authorize Agent::Statistic
  #   @agent_statistic = Agent::Statistic.new(agent_statistic_params)
  # end
  #
  # def edit
  #   authorize @agent_statistic
  # end
  #
  # def create
  #   authorize Agent::Statistic
  #   @agent_statistic = Agent::Statistic.new(permitted_attributes(Agent::Statistic)))
  #
  #   respond_to do |format|
  #     format.html do
  #       if @agent_statistic.save
  #         redirect_to agent_statistic_path(@agent_statistic), notice: 'Statistic 创建成功.'
  #       else
  #         render :new
  #       end
  #     end
  #     format.json { render json: @agent_statistic }
  #   end
  #
  # end
  #
  # def update
  #   authorize @agent_statistic
  #   respond_to do |format|
  #     format.html do
  #       if @agent_statistic.update(permitted_attributes(@agent_statistic))
  #         redirect_to agent_statistic_path(@agent_statistic), notice: 'Statistic 更新成功.'
  #       else
  #         render :edit
  #       end
  #     end
  #     format.json { render json: @agent_statistic }
  #   end
  # end
  #
  # def destroy
  #   authorize @agent_statistic
  #   @agent_statistic.destroy
  #   respond_to do |format|
  #     format.html { redirect_to agent_statistics_url, notice: 'Statistic 删除成功.' }
  #     format.json { head 200 }
  #   end
  #
  # end
  #
  # private
  #   # Use callbacks to share common setup or constraints between actions.
  #   def set_agent_statistic
  #     @agent_statistic = Agent::Statistic.find(params[:id])
  #   end
  #
  #   # Only allow a trusted parameter "white list" through.
  #   def agent_statistic_params
  #     params.require(:agent_statistic).permit(:index)
    # end
end
