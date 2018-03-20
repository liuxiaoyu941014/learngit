# 仓库物料库存
class Api::V1::MaterialWarehouseItemsController < Api::V1::BaseController
  before_action :authenticate!

  # 获得物料仓库列表
  # @return [JSON]
  def index
    # authorize MaterialWarehouse
    material_warehouse_items = MaterialWarehouseItem.where(material_warehouse_id: params["material_warehouse_id"], material_id: params["material_id"])
    render json: {
      material_warehouse_items: material_warehouse_items_json(material_warehouse_items)
    }
  end

  private

  def material_warehouse_items_json(material_warehouse_items)
    material_warehouse_items.as_json(only: %w(id material_warehouse_id material_id stock))
  end

end
