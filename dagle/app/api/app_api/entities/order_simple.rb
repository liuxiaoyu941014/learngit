module AppAPI
  module Entities
    class OrderSimple < Base

      # public attributes
      expose_id
      expose_created_at
      expose_updated_at
      expose :code, documentation: { desc: '订单号' }
      # expose :price, documentation: { desc: '价格', type: Float }
      expose :status, documentation: { desc: '状态' }
      expose :display_price, as: :price, documentation: { desc: '产品价格', type: Float}
      expose :refund_status, documentation: { desc: '退款状态' }
      expose :refund_description, documentation: { desc: '退款描述' }
      if Settings.project.imolin?
        expose :display_delivery_fee, as: :delivery_fee, documentation: { desc: '配送费', type: Float }
        expose :delivery_username, documentation: { desc: '收货人' }, if: ->(order, options) { options[:action] != :destroy}
        expose :delivery_phone, documentation: { desc: '联系方式' }, if: ->(order, options) { options[:action] != :destroy}
        expose :delivery_address, documentation: { desc: '收货地址' }, if: ->(order, options) { options[:action] != :destroy}

        def display_delivery_fee
          object.delivery_fee.to_f/100
        end
      end

      def display_price
        object.price.to_f/100
      end

    end
  end
end
