# csv support
require 'csv'
class Admin::MaterialManagementsController < Admin::BaseController
  before_action :set_material_management, only: [:show, :edit, :update, :destroy]
  before_action :set_type, only: [:index,:new]
  # GET /admin/material_managements
  def index
    authorize MaterialManagement
    @filter_colums = %w(id)
    return redirect_to admin_root_path, alert: "访问的页面不存在" unless @type
    @material_managements_all = MaterialManagement.all.send(@type)
    if params[:search] && params[:search][:keywords]
      material_id = Material.where("name_py like :key OR name like :key", {key: ['%',params['search']['keywords'].upcase, '%'].join}).pluck(:id)
      @material_managements_all = @material_managements_all.joins("join material_management_details on material_management_details.material_management_id = material_managements.id").where("material_management_details.material_id in (?)", material_id)
    end
    if params["daterange"].present?
      date_range = params["daterange"].split(' - ').map(&:strip).map(&:to_date)
      @material_managements_all = @material_managements_all.where("operate_date in (?)", date_range[0]..date_range[1])
    end
    @material_managements = @material_managements_all.order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@material_managements.to_json, filename: "material_managements-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@material_managements.to_xml, filename: "material_managements-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(to_csv(@material_managements_all), filename: "material_managements-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/material_managements/1
  def show
    authorize @material_management
  end

  # GET /admin/material_managements/new
  def new
    authorize MaterialManagement
    @material_management = MaterialManagement.new(operate_type: @type)
  end

  # GET /admin/material_managements/1/edit
  def edit
    authorize @material_management
  end

  # POST /admin/material_managements
  def create
    authorize MaterialManagement
    flag, @material_management = MaterialManagement::Create.(permitted_attributes(MaterialManagement))

    if flag
      redirect_to admin_material_management_path(@material_management), notice: "#{MaterialManagement.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/material_managements/1
  def update
    authorize @material_management
    flag, @material_management = MaterialManagement::Update.(@material_management, permitted_attributes(MaterialManagement))
    if @material_management.update(permitted_attributes(@material_management))
      redirect_to admin_material_management_path(@material_management), notice: "#{MaterialManagement.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/material_managements/1
  def destroy
    authorize @material_management
    @material_management.destroy
    redirect_to admin_material_managements_url, notice: "#{MaterialManagement.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material_management
      @material_management = MaterialManagement.find(params[:id])
    end

    def set_type
      @type = nil
      if ['output', 'input'].include?(params[:type])
        @type = params[:type]
        @operate_type_name = enum_i18n(MaterialManagement, :operate_type, @type)
      else
        raise "unknown operate_type"
      end
    end

    def to_csv(objects)
      return [] if objects.nil?
      type = enum_i18n(MaterialManagement, :operate_type, @type)
      # make excel using utf8 to open csv file
      head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join()
      CSV.generate(head) do |csv|
        csv << [type + '总量', objects.sum{ |p| p.material_management_details.sum(:number) }, type + '总金额', objects.sum{ |p| p.material_management_details.sum{|mmd| mmd.number * (mmd.price || mmd.material.price) } }]
        # 获取字段名称
        column_names = [ type + '日期','物料名称', '编码', '价格', '数量', '总金额']
        csv << column_names
        objects.each do |obj|
          obj.material_management_details.each do |mmd|
            values = []
            price = mmd.price || mmd.material.price
            values << obj.operate_date
            values << mmd.material.name
            values << mmd.material.name_py
            values << price
            values << mmd.number
            values << price * mmd.number
            csv << values
          end
        end
      end
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_material_management_params
    #       #   params.require(:admin_material_management).permit(policy(@admin_material_management).permitted_attributes)
    #       # end
end
