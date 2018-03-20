class Api::V1::LogisticsController < Api::V1::BaseController
  before_action :authenticate!

  def change_status
    logistic = Logistic.find(params[:id])
    if params[:status] == 'completed'
      logistic.completed!
      render json: {
        status: 'ok',
        logistic: logistic.as_json(
          only: [:status, :id, :updated_at],
          include: {
            delivery: { only: [:id, :name], methods: [:address, :phone_number]},
            create_user: { only: [:id, :nickname] },
            update_user: { only: [:id, :nickname] }
          }
        )
      }
    else
      render json: {status: 'errors'}
    end
  end
end
