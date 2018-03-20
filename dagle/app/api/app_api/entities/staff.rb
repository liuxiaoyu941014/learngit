module AppAPI
  module Entities
    class Staff < Base

      # public attributes
      expose_id
      expose :title, documentation: { desc: '美容师名称' }
      expose :description, documentation: { desc: '描述' }
      expose :content, documentation: { desc: '详细介绍' }
      expose :age, documentation: { desc: '年龄' }
      expose :work_years, documentation: { desc: '工作年限' }
      expose :sco, documentation: { desc: '总评分-星星' }
      expose :score, documentation: { desc: '总评分' }
      expose :total_service, documentation: { desc: '总服务数' }
      expose :week_service, documentation: { desc: '周服务数' }
      expose :pro, documentation: { desc: '擅长领域' }
      expose :image_items, using: AppAPI::Entities::ImageItem, as: :images

      def pro
        object.properties.map{|p| ::Staff::PROPERTIES[p.to_sym]}.compact.join('，')
      end

      def sco
        BigDecimal(object.score.to_s).ceil
      end

      #expose :products, using: AppAPI::Entities::Product, if: ->(shop, options) { (options[:includes] || []).include?(:products) }
      # # product detail
      # with_options if: ->(site, options) { options[:type] == :full_site } do |f|
      #   expose :products, using: AppAPI::Entities::Product
      # end
    end
  end
end
