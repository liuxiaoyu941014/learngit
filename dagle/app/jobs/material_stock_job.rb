class MaterialStockJob
  include Sidekiq::Worker

  def perform(material_id)
    material = Material.find(material_id)
    alert = MaterialStockAlert.find_or_create_by(material: material)
    if material.stock <= material.min_stock.to_i
      alert.title  = "库存预警通知"
      alert.body   = material.stock == 0 ? "没有库存了，请尽快补充" : "当前的库存为：#{material.stock}, 已低于最低库存要求：#{material.min_stock.to_i}, 请及时补充物料"
      alert.status = 'unprocessed'
    else
      alert.title  = "库存正常"
      alert.body   = "当前的库存为：#{material.stock}, 物料最低库存要求为：#{material.min_stock.to_i}"
      alert.status = 'processed'
    end
    alert.save!
  end
end
