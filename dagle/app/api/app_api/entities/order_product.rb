module AppAPI
  module Entities
    class OrderProduct < Base
      # public attributes
      expose_id
      expose :product, using: AppAPI::Entities::ProductSimple
      expose :amount, documentation: { desc: '产品数量', type: Integer }
      # expose :price, documentation: { desc: '产品价格', type: Float }
      expose :display_price, as: :price, documentation: { desc: '产品价格', type: Float}

      def display_price
        object.price.to_f/100
      end
    end
  end
end
