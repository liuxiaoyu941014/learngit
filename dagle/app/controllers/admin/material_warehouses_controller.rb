# csv support
require 'csv'
class Admin::MaterialWarehousesController < Admin::BaseController
  before_action :set_material_warehouses
  before_action :set_material_warehouse, only: [:show, :edit, :update, :destroy]

  # GET /admin/material_warehouses
  def index
    authorize MaterialWarehouse
    @filter_colums = %w(name)
    @material_warehouses = build_query_filter(@material_warehouses, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@material_warehouses.to_json, filename: "material_warehouses-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@material_warehouses.to_xml, filename: "material_warehouses-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@material_warehouses.as_csv(only: [:id, :name, :warehouse_user, :phone, :warehouse_address]), filename: "material_warehouses-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/material_warehouses/1
  def show
    authorize @material_warehouse
  end

  # GET /admin/material_warehouses/new
  def new
    authorize MaterialWarehouse
    @material_warehouse = MaterialWarehouse.new
  end

  # GET /admin/material_warehouses/1/edit
  def edit
    authorize @material_warehouse
  end

  # POST /admin/material_warehouses
  def create
    authorize MaterialWarehouse
    @material_warehouse = MaterialWarehouse.new(permitted_attributes(MaterialWarehouse))

    if @material_warehouse.save
      redirect_to admin_material_warehouse_path(@material_warehouse), notice: "#{MaterialWarehouse.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/material_warehouses/1
  def update
    authorize @material_warehouse
    if @material_warehouse.update(permitted_attributes(@material_warehouse))
      redirect_to admin_material_warehouse_path(@material_warehouse), notice: "#{MaterialWarehouse.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/material_warehouses/1
  def destroy
    authorize @material_warehouse
    if @material_warehouses.size > 1
      authorize @material_warehouse
      @material_warehouse.destroy
      redirect_to admin_material_warehouses_path, notice: "#{MaterialWarehouse.model_name.human} 删除成功."
    else
      redirect_to admin_material_warehouses_path, notice: "仓库必须至少保留一个."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_warehouse
      @material_warehouse = @material_warehouses.find(params[:id])
    end

    def set_material_warehouses
      @material_warehouses = MaterialWarehouse.all
    end
    # Only allow a trusted parameter "white list" through.
    # def admin_material_warehouse_params
    #       #   params[:admin_material_warehouse]
    #       # end
end
