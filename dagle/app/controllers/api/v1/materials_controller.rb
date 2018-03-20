# 物料

class Api::V1::MaterialsController < Api::V1::BaseController
  before_action :authenticate!
  before_action :set_order, only: [:index]
  before_action :set_material, only: [:update, :show, :audit, :purchase]
  # 获得物料列表
  # @param [Integer] page 页码
  # @param [Integer] page_size 每页显示数据
  # @return [JSON]
  def index
    # authorize Material
    if params[:order_id].present?
      materials = @order.materials.order(created_at: :desc)
      render json: {materials: materials}
    else
      page_size = params[:page_size].present? ? params[:page_size].to_i : 20
      materials = params['search_content'].present? ? Material.where("name_py like :key OR name like :key", {key: ['%',params['search_content'].upcase, '%'].join}) : Material.all
      if params["catalog_id"].present?
        catalog = MaterialCatalog.find_by_id(params[:catalog_id])
        catalog_ids = [catalog.id] + catalog.children.map(&:id)
        materials = materials.where(catalog_id: catalog_ids)
      end
      materials = materials.order(created_at: :desc).page(params[:page] || 1).per(page_size)
      render json: {
        materials: material_json(materials),
        page_size: page_size,
        current_page: materials.current_page,
        total_pages: materials.total_pages,
        total_count: materials.total_count
      }
    end
  end

  def create
    authorize Material
    material = Material.new(permitted_attributes(Material))
    material.features = material.features.merge(params["material"]['features'])
    if material.save
      render json: {status: 'ok', material: material_json(material)}
    else
      render json: {status: 'failed', error_message:  material.errors.full_messages.join(', ')}
    end
  end

  def batch_create
    authorize Material
    flag, message, materials = parse_material_upload_file
    if flag
      render json: {status: 'ok', materials: material_json(materials)}
    else
      render json: {status: 'failed', error_message:  message }
    end
  end

  def update
    authorize @material
    # @material.features = {}
    @material.features = params["material"]['features']
    flag, material = Material::Update.(@material, permitted_attributes(@material))
    # params_featues = params["material"]['features']
    # params_featues.delete('unit')
    # material.features = material.features.merge(params_featues)
    if flag #&& material.save
      render json: {status: 'ok', material: material_json(material)}
    else
      render json: {status: 'failed', error_message:  material.errors.full_messages.join(', ') }
    end
  end

  def show
    # authorize @material
    render json: {status: 'ok', material: material_json(@material)}
  end

  def audit
    authorize @material
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    audits = @material.audits.page(params[:page] || 1).per(page_size)
    render json: {
      audits: audits.as_json(only: %w(id action audited_changes created_at), methods: %w(user)).reverse,
      page_size: page_size,
      current_page: audits.current_page,
      total_pages: audits.total_pages,
      total_count: audits.total_count
    }
  end

  def purchase
    # authorize @material
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    purchases = @material.material_purchase_details.order(created_at: :desc).page(params[:page] || 1).per(page_size)
    render json: {
      purchases: purchases.as_json(
        only: %w(id number input_number price created_at), 
        include: {
          material_purchase: {
            only: %w(status vendor_id),
            methods: %w(purchase_date),
            include: {vendor: {only: %w(id name)}}
          }
        }
      ),
      page_size: page_size,
      current_page: purchases.current_page,
      total_pages: purchases.total_pages,
      total_count: purchases.total_count
    }    
  end

  def get_csv
    authorize Material
    materials = params['search_content'].present? ? Material.where("name_py like :key OR name like :key", {key: ['%',params['search_content'].upcase, '%'].join}) : Material.includes(:catalog).all
    if params["catalog_id"].present?
      catalog = MaterialCatalog.find_by_id(params[:catalog_id])
      catalog_ids = [catalog.id] + catalog.children.map(&:id)
      materials = materials.where(catalog_id: catalog_ids)
    end
    render json: {
      status: 'ok', materials: materials.as_json(only: %w(name name_py), methods: %w(stock price unit), include: {catalog: { only: %w(id name)} })
    }
  end

  private

  def set_order
    @order = Order.where(id: params[:order_id]).first if params[:order_id].present?
  end

  def set_material
    @material = Material.find_by_id(params[:id])
  end

  def material_json(material)
    material.as_json(
      only: %w(id name name_py catalog_id features),
      methods: %w(stock image_item_ids price unit vendor_ids),
      include: {
        vendors: { only: %w(id name)},
        catalog: { only: %w(id name features), methods: %w(full_name) },
        image_items: { only: %w(id), methods: %w(image_url image_file_name) },
        material_warehouse_items: { only: %w(material_warehouse_id stock),
          include: {material_warehouse: {only: %w{name}}}
        }
      }
    )
  end

  def parse_material_upload_file
    require 'roo'
    message = ""
    all_upload = true
    materials = []
    worksheet = nil
    file_path = params["file"].path
    if File.extname(file_path) == ".xlsx"
      worksheet = Roo::Excelx.new(file_path)
    elsif File.extname(file_path) == ".xls"
      worksheet = Roo::Excel.new(file_path)
    elsif File.extname(file_path) == ".csv"
      worksheet = Roo::CSV.new(file_path)
    end
    # ["物料分类", "物料名称", "供应商", "单位", "单价"]
    if worksheet
      header = worksheet.row(1)
      if header[0..5].join(',') == "物料分类,物料名称,单位,单价,供应商,数量"
        warehouse = MaterialWarehouse.find_or_create_by(name: '原材料库')
        Material.transaction do
          2.upto worksheet.last_row do |index|
            # .row(index) will return the row which is a subclass of Array
            row = worksheet.row(index)

            material_catalog_id = MaterialCatalog.where(name: row[0]).first.try(:id)

            unless material_catalog_id
              message = '找不到物料分类：'+ row[0] + '，请检查！'
              all_upload = false
              raise ActiveRecord::Rollback
              break
            end

            attributes = {
              catalog_id:   MaterialCatalog.where(name: row[0]).first.try(:id),
              name:         row[1],
              vendor_ids:   Vendor.find_or_create_by(name: row[4]).id
            }

            features = {}

            features['unit'] = row[2]
            features['price'] = row[3]


            (6..(row.size-1)).to_a.each do |s_index|
              features[header[s_index]] = row[s_index] if row[s_index].present?
            end

            attributes["features"] = features

            flag, material = Material::Create.(attributes)
            if flag
              materials.push(material)
              if row[5].to_i > 0
                MaterialManagement::Create.({
                  operate_type: 'input',
                  operate_date: Time.now.to_date,
                  material_warehouse_id: warehouse.id,
                  material_management_details_attributes: [{material_id: material.id, number: row[5]}]
                })
              end
            else
              material.errors.messages.each_pair do |k, v|
                message += material.send(k) +':'+ v.join(':')
              end
              all_upload = false
              raise ActiveRecord::Rollback
              break
            end
          end
        end
      else
        all_upload = false
        message = '列名不正确，请按照模版内列名填写！'
      end
    else
      all_upload = false
      message = '文件格式不正确！'
    end

    [all_upload, message, materials]
  end

end
