class Agent::MessagesController < Agent::BaseController
  before_action :set_agent_messages
  before_action :set_agent_message, only: [:update]

  def index
  end

  def update
    if @agent_message.update(read_at: Time.now)
      render json: {status: 'ok'}
    else
      render json: {status: 'failed'}
    end
  end

  private
    def set_agent_message
      @agent_message = @agent_messages.find(params[:id])
    end

    def set_agent_messages
      @agent_messages = Notification.where(user_id: current_user.id).unread.order(created_at: :asc)
    end
end
