# csv support
require 'csv'
class Admin::ProducesController < Admin::BaseController
  before_action :set_order, except: [:index]
  before_action :set_produce, only: [:show, :edit, :update, :destroy]

  # GET /admin/produces
  def index
    authorize Produce
    @filter_colums = %w(id)
    @produces = build_query_filter(Produce.all, only: @filter_colums).order(status: :desc, created_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@produces.to_json, filename: "produces-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@produces.to_xml, filename: "produces-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@produces.as_csv(), filename: "produces-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/produces/1
  def show
    authorize @produce
  end

  # GET /admin/produces/new
  def new
    authorize Produce
    @produce = Produce.new
  end

  # GET /admin/produces/1/edit
  def edit
    authorize @produce
  end

  # POST /admin/produces
  def create
    authorize Produce
    @produce = @order.produce
    unless @produce
      @produce = Produce.new(order: @order)
      return redirect_to admin_order_path(@order), notice: "生产任务创建失败." unless @produce.save
    end
    redirect_to admin_produces_path, notice: "#{Produce.model_name.human} 创建成功."
  end

  # PATCH/PUT /admin/produces/1
  def update
    authorize @produce
    if @produce.update(permitted_attributes(@produce))
      render json: {message: '修改成功.'}
    else
      render json: {error: '修改失败'}
    end
  end

  # DELETE /admin/produces/1
  def destroy
    authorize @produce
    @produce.destroy
    redirect_to admin_produces_path, notice: "#{Produce.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_produce
      @produce = Produce.find(params[:id])
    end

    def set_order
      @order = Order.find(params[:order_id])
    end
    # Only allow a trusted parameter "white list" through.
    # def admin_produce_params
    #       #   params[:admin_produce]
    #       # end
end
