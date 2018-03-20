class MaterialManagement
  Create =
    lambda do |attributes, user: nil|
      flag = false
      record = nil
      MaterialManagement.transaction do
        record = MaterialManagement.new(attributes)
        material_warehouse = record.material_warehouse

        if record.material_management_details.empty?
          record.errors.add(:material_management_details, '为空')
          return [false, record]
        end
        if material_warehouse.nil?
          record.errors.add(:material_warehouse, '为空')
          return [false, record]
        end
        # 出库时，检查库存是否充足
        if attributes["operate_type"] == 'output'
          # 检查仓库的库存是否足够
          alert_materials = []
          details = attributes[:material_management_details_attributes].is_a?(Array) ?  attributes[:material_management_details_attributes] : attributes[:material_management_details_attributes].values
          details.each do |detail|
            material = Material.find(detail["material_id"])
            warehouse_stock = material_warehouse.material_warehouse_items.find_by(material: material).try(:stock) || 0
            alert_materials << material.name if warehouse_stock < detail["number"].to_i
          end

          unless alert_materials.blank?
            record.errors.add(:description, ": #{alert_materials.join(', ')}库存不足")
            return [false, record]
          end
        end

        # 开始增减库存
        record.material_management_details.each do |mmd|
          # 仓库中物料的库存
          if record.output?
            material_warehouse_item = material_warehouse.material_warehouse_items.find_by(material: mmd.material)
            material_warehouse_item.stock -= mmd.number
          elsif record.input?

            # 价格根据采购价格自动做加权平均，计算物料的成本价格
            mmd.material.price = (mmd.price * mmd.number + mmd.material.stock * mmd.material.price.try(:to_f))/(mmd.number + mmd.material.stock)
            mmd.material.save!

            material_warehouse_item = material_warehouse.material_warehouse_items.find_or_create_by(material: mmd.material)
            material_warehouse_item.stock += mmd.number if mmd.number
          end
          material_warehouse_item.save!
        end
        flag = record.save
        raise ActiveRecord::Rollback unless flag
      end
      [flag, record]
    end
end
