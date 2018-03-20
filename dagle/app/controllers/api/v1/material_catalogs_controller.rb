# 物料分类

class Api::V1::MaterialCatalogsController < Api::V1::BaseController
  before_action :authenticate!

  # 获得物料列表
  # @return [JSON]
  def index
    # authorize MaterialCatalog
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    material_catalogs = params['name'].present? ? MaterialCatalog.where("name like :key", {key: ['%',params['name'].upcase, '%'].join}) : MaterialCatalog.all
    if params[:parent_id].present? && params[:parent_id] == 'null'
      material_catalogs = material_catalogs.where(parent_id: nil)
      render json: {
        material_catalogs: material_catalog_children_json(material_catalogs),
      }
    else
      material_catalogs = material_catalogs.order(created_at: :desc).page(params[:page] || 1).per(page_size)
      material_catalogs_data = material_catalogs.map{|mc| mc.self_and_descendants }.flatten.uniq
      render json: {
        material_catalogs: material_catalog_json(material_catalogs_data),
        page_size: page_size,
        current_page: material_catalogs.current_page,
        total_pages: material_catalogs.total_pages,
        total_count: material_catalogs.total_count
      }
    end
  end

  private

  def material_catalog_json(material_catalogs)
    material_catalogs.as_json(only: %w(id name parent_id position features), methods: [:full_name])
  end

  def material_catalog_children_json(material_catalogs)
    material_catalogs.as_json(only: %w(id name parent_id), methods: [:children])
  end

end
