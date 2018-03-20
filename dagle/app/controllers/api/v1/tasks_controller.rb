class Api::V1::TasksController < Api::V1::BaseController
  before_action :authenticate!
  before_action :set_produce

  def index
    # authorize Task
    if params[:user_id].present?
      user = User.find(params[:user_id])
      tasks = user.tasks.joins("join produces on produces.id = tasks.resource_id").where("tasks.resource_type = ?",'Produce').where("tasks.status not in (1, 2)").order("produces.created_at asc, tasks.ordinal asc").page(params[:page]).per(params[:page_size])
      render json: {
        status: 'ok',
        current_page: tasks.current_page,
        total_pages: tasks.total_pages,
        total_count: tasks.total_count,
        tasks: tasks.as_json(
          only: %w(id title description ordinal status created_at),
          include: {
            task_type: {
              only: %w(name)
            },
            user: {
              only: %w(id nickname)
            },
            resource: {
              only: %w(id created_at),
              include: {
                order: {
                  only: %w(id code),
                  include: {
                    order_materials: {
                      only: %w(id amount factory_expected_number practical_number material_id),
                      include: {
                        material: {
                          only: [:name]
                        }
                      }
                    }
                  }
                }
              }
            }
          }
        )
      }
    else
      render json: task_json(@produce.tasks)
    end
  end

  def create
    authorize @produce.tasks
    flag, task = Task::Create.(permitted_attributes(Task).merge({resource: @produce, creator_id: @current_user.id}))
    if flag
      render json: {status: 'ok', task: task_json(task)}
    else
      render json: {status: 'failed', error_message: task.errors.messages.inject(''){ |k, v| k += v.join(':') + '. '} }
    end
  end

  def update
    authorize @produce.tasks
    task = Task.find(params[:id])
    flag, task = Task::Update.(task, permitted_attributes(task))
    if flag
      render json: {status: 'ok', task: task_json(task)}
    else
      render json: {status: 'failed', error_message: task.errors.messages.inject(''){ |k, v| k += v.join(':') + '. '} }
    end
  end

  private
  def set_produce
    @produce = Produce.find(params["produce_id"]) if params[:produce_id].present?
  end

  def task_json(tasks)
    tasks.as_json(
      only: [:id, :assignee_id, :title, :description, :status, :resource_id],
      include: {task_type: {only: [:id, :name, :ordinal]}}
    )
  end

end
