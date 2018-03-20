class Agent::PreorderConversitionsController < Agent::BaseController
  before_action :set_preorder_conversitions
  before_action :set_preorder_conversition, only: [:show, :edit, :update, :destroy, :site_confirm]
  acts_as_commentable resource: Ticket

  def index
    # authorize
    if params[:search].present?
      keywords = params[:search][:keywords]
      query = []
      conditions = []
      query << "title like ? or content like ?"
      conditions << "%" + keywords + "%"
      conditions << "%" + keywords + "%"
      conditions.unshift query.join(' AND ')
      @preorder_conversitions = @preorder_conversitions.where(conditions)
    end
    if params[:sort].present?
      case params[:sort]
      when 'newest'
        @preorder_conversitions = @preorder_conversitions.order(updated_at: :desc)
      end
    end
    @preorder_conversitions = @preorder_conversitions.page(params[:page]).per(9)
    respond_to do |format|
      format.html
      format.json { render json: @preorder_conversitions }
    end
  end

  def show
    # authorize
    respond_to do |format|
      format.html
      format.json { render json: @preorder_conversition }
    end
  end

  # def new
  #   authorize PreorderConversition
  #   @preorder_conversition = PreorderConversition.new(preorder_conversition_params)
  # end
  #
  # def edit
  #   authorize @preorder_conversition
  # end

  def create
    # authorize preorder_conversition
    member = Member.where(id: params[:preorder_conversition][:member_id]).first
    @preorder_conversition = @site.preorder_conversitions.new(permitted_attributes(PreorderConversition).merge(user_id: current_user.id, member_name: member.name, member_phone: member.mobile_phone))
    if @preorder_conversition.save
      render json: {status: 'ok', url: agent_preorder_conversitions_path}
    else
      render json: {status: 'error', message:@preorder_conversition.errors.full_messages.join(',')}
    end
  end

  # def update
  #   authorize @preorder_conversition
  #   respond_to do |format|
  #     format.html do
  #       if @preorder_conversition.update(permitted_attributes(@preorder_conversition))
  #         redirect_to agent_preorder_conversition_path(@preorder_conversition), notice: 'Preorder conversition 更新成功.'
  #       else
  #         render :edit
  #       end
  #     end
  #     format.json { render json: @preorder_conversition }
  #   end
  # end
  #
  # def destroy
  #   authorize @preorder_conversition
  #   @preorder_conversition.destroy
  #   respond_to do |format|
  #     format.html { redirect_to agent_preorder_conversitions_url, notice: 'Preorder conversition 删除成功.' }
  #     format.json { head 200 }
  #   end
  #
  # end
  def site_confirm
    if @preorder_conversition.update(site_confirm: true)
      render json: {status: 'ok', factory_confirm: @preorder_conversition.factory_confirm.to_json}
    else
      render json: {status: 'error', message: preorder_conversition.errors.full_messages.join(',')}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_preorder_conversition
      @preorder_conversition = @preorder_conversitions.find(params[:id])
    end

    def set_preorder_conversitions
      @preorder_conversitions = @site.preorder_conversitions
    end

end
