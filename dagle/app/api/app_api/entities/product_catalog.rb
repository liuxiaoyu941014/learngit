module AppAPI
  module Entities
    class ProductCatalog < Base
      # 公开出来的属性
      expose_id
      expose :name, documentation: { desc: '分类名称' }
      expose :is_hot, documentation: { desc: '是否是热门服务' }
      expose :products, using: AppAPI::Entities::Product, if: ->(site, options) { (options[:includes] || []).include?(:products) }
    end
  end
end
