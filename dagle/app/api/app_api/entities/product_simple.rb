module AppAPI
  module Entities
    class ProductSimple < Base
      expose_id
      expose :name, documentation: { desc: '产品名称' }
      # expose :sell_price, documentation: {desc: '产品卖价', type: Float }
      # expose :price, documentation: {desc: '产品原价', type: Float}
      expose :comments_count, documentation: {desc: '产品评论的数量', type: Integer }
      expose :favorites_count, documentation: {desc: '产品收藏的数量', type: Integer }
      expose :visits_count, documentation: {desc: '产品访问的数量', type: Integer }
      expose :likes_count, documentation: {desc: '产品喜爱的数量', type: Integer }
      expose :sales_count, documentation: {desc: '产品的销量', type: Integer }
      expose :site, using: AppAPI::Entities::SiteSimple
      expose :image_items, using: AppAPI::Entities::ImageItemSimple, documentation: { is_array: true }, as: :images
      expose :first_image, documentation: {desc: '产品默认图片'}
      with_options if: ->(products, options) { options.fetch(:includes, []).map(&:to_s).include?('favoriters') } do |f|
        expose :favoriters, documentation: { desc: "产品的捧场用户", is_array: true }
      end

      expose :display_sell_price, documentation: { desc: '产品价格', type: Float}, as: :sell_price
      expose :display_price, documentation: { desc: '产品原价', type: Float}, as: :price
      
      with_options if: ->(products, options) { options.fetch(:includes, []).map(&:to_s).include?('tags') } do |f|
        expose :tag_list, documentation: { desc: "产品的标签,特点", is_array: true }
      end

      def display_sell_price
        object.sell_price.to_f/100
      end

      def display_price
        object.price.to_f/100
      end

      def favoriters
        object.favorites.as_json(only: [], include: { user: {only: [:nickname], methods: [:display_headshot]}})
      end
    end
  end
end
