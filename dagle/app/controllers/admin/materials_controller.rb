# csv support
require 'csv'
class Admin::MaterialsController < Admin::BaseController
  before_action :set_material, only: [:show, :edit, :update, :destroy]

  def dashboard
    authorize Material
  end
  # GET /admin/materials
  def index
    authorize Material
    @materials_all = params['keywords'].present? ? Material.where("name_py like :key OR name like :key", {key: ['%',params['keywords'].upcase, '%'].join}) : Material.all

    if params["catalog_id"].present?
      catalog = MaterialCatalog.find_by_id(params[:catalog_id])
      catalog_ids = [catalog.id] + catalog.children.map(&:id)
      @materials_all = @materials_all.where(catalog_id: catalog_ids)
    end

    @materials = @materials_all.order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:format] == "json"
        # format.html { send_data(@materials.to_json, filename: "materials-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
        format.json do
          render json: @materials.as_json(only: [:id, :name, :name_py], methods: [:stock, :price])
        end
      elsif params[:xml].present?
        format.html { send_data(@materials.to_xml, filename: "materials-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        format.html { send_data(to_csv(@materials_all), filename: "materials-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/materials/1
  def show
    authorize @material
  end

  # GET /admin/materials/new
  def new
    authorize Material
    @material = Material.new
  end

  # GET /admin/materials/1/edit
  def edit
    authorize @material
  end

  # POST /admin/materials
  def create
    authorize Material
    @material = Material.new(permitted_attributes(Material))

    if @material.save
      redirect_to admin_material_path(@material), notice: 'Material 创建成功.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/materials/1
  def update
    authorize @material
    if @material.update(permitted_attributes(@material))
      redirect_to admin_material_path(@material), notice: 'Material 更新成功.'
    else
      render :edit
    end
  end

  # DELETE /admin/materials/1
  def destroy
    authorize @material
    @material.destroy
    redirect_to admin_materials_url, notice: 'Material 删除成功.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_material
      @material = Material.find(params[:id])
    end

    def to_csv(objects)
      return [] if objects.nil?
      # make excel using utf8 to open csv file
      head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join()
      CSV.generate(head) do |csv|
        csv << ['物料总量', objects.sum{ |p| p.stock }, '总金额', objects.sum{ |p| p.price * p.stock }]
        # 获取字段名称
        column_names = [ '物料名称', '编码', '价格', '数量', '总金额', '物料分类']
        csv << column_names
        objects.each do |obj|
          values = []
          values << obj.name
          values << obj.name_py
          values << obj.price
          values << obj.stock
          values << obj.price * obj.stock
          values << obj.catalog.try(:name)
          csv << values
        end
      end
    end


    # Only allow a trusted parameter "white list" through.
    # def admin_material_params
    #       #   params.require(:admin_material).permit(policy(@admin_material).permitted_attributes)
    #       # end
end
