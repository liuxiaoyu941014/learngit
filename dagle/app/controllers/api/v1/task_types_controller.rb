class Api::V1::TaskTypesController < Api::V1::BaseController
  before_action :authenticate!

  def index
    # authorize TaskType
    @task_types = TaskType.all
    if params[:produce_id].present?
      produce = Produce.find(params[:produce_id])
      @task_types = TaskType.where.not(id: produce.tasks)
    end
    render json: {task_types: @task_types.as_json(only: %w(id name ordinal))}
  end

end
