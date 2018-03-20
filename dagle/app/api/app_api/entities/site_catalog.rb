module AppAPI
  module Entities
    class SiteCatalog < Base
      # 公开出来的属性
      expose_id
      expose :name, documentation: { desc: '分类名称' }
      expose :icon_url, documentation: { desc: '图标链接' }
      expose :children, using: AppAPI::Entities::SiteCatalog, documentation: { is_array: true }, if: ->(site_catalog, options) { (options[:includes] || []).include?(:children) }
    end
  end
end
