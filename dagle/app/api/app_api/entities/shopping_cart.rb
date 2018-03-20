module AppAPI
  module Entities
    class ShoppingCart < Base

      # public attributes
      expose_id
      expose :amount, documentation: { desc: '产品数量', type: Integer }
      # expose :price, documentation: { desc: '产品价格', type: Float }
      expose :product, using: AppAPI::Entities::Product, if: lambda { |instance, options| (options[:includes] || []).include?(:product) }
      expose :site_name, if: lambda { |instance, options| (options[:includes] || []).include?(:site) }
      expose :display_price, documentation: { desc: '产品价格', type: Float}, as: :price

      def display_price
        object.price.to_f/100
      end

      def site_name
        object.product.site.title
      end
    end
  end
end
