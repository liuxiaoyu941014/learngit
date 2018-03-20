# csv support
require 'csv'
class Admin::OrderMaterialsController < Admin::BaseController
  before_action :set_order
  before_action :set_order_material, only: [:show, :edit, :update, :destroy]

  # GET /admin/order_materials
  def index
    authorize OrderMaterial
    @filter_colums = %w(id)
    @order_materials = build_query_filter(OrderMaterial.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@order_materials.to_json, filename: "order_materials-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@order_materials.to_xml, filename: "order_materials-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@order_materials.as_csv(), filename: "order_materials-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/order_materials/1
  def show
    authorize @order_material
  end

  # GET /admin/order_materials/new
  def new
    authorize @order.order_materials
    @order_material = @order.order_materials.new
  end

  # GET /admin/order_materials/1/edit
  def edit
    authorize @order_material
  end

  # POST /admin/order_materials
  def create
    authorize @order.order_materials
    @order_material = @order.order_materials.new(permitted_attributes(@order.order_materials))

    if @order_material.save
      redirect_to admin_order_path(@order), notice: "#{OrderMaterial.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/order_materials/1
  def update
    authorize @order_material
    if @order_material.update(permitted_attributes(@order_material))
      redirect_to admin_order_path(@order), notice: "#{OrderMaterial.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/order_materials/1
  def destroy
    authorize @order_material
    @order_material.destroy
    redirect_to admin_order_path(@order), notice: "#{OrderMaterial.model_name.human} 删除成功."
  end

  private
    def set_order
      @order = Order.find(params[:order_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_order_material
      @order_material = @order.order_materials.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_order_material_params
    #       #   params.require(:admin_order_material).permit(policy(@admin_order_material).permitted_attributes)
    #       # end
end
