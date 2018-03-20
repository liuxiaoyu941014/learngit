# csv support
require 'csv'
class Admin::TaskTypesController < Admin::BaseController
  before_action :set_task_type, only: [:show, :edit, :update, :destroy]

  # GET /admin/task_types
  def index
    authorize TaskType
    @filter_colums = %w(name)
    @task_types = build_query_filter(TaskType.all, only: @filter_colums).order(ordinal: :asc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@task_types.to_json, filename: "task_types-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@task_types.to_xml, filename: "task_types-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@task_types.as_csv(), filename: "task_types-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/task_types/1
  def show
    authorize @task_type
  end

  # GET /admin/task_types/new
  def new
    authorize TaskType
    @task_type = TaskType.new
  end

  # GET /admin/task_types/1/edit
  def edit
    authorize @task_type
  end

  # POST /admin/task_types
  def create
    authorize TaskType
    @task_type = TaskType.new(permitted_attributes(TaskType))

    if @task_type.save
      redirect_to admin_task_types_path, notice: "#{TaskType.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/task_types/1
  def update
    authorize @task_type
    if @task_type.update(permitted_attributes(@task_type))
      redirect_to admin_task_types_path, notice: "#{TaskType.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/task_types/1
  def destroy
    authorize @task_type
    @task_type.destroy
    redirect_to admin_task_types_url, notice: "#{TaskType.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task_type
      @task_type = TaskType.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_task_type_params
    #       #   params[:admin_task_type]
    #       # end
end
