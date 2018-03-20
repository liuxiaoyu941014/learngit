module AppAPI::V1
  class Order < AppAPI::BaseAPI
    helpers AppAPI::SharedParams
    resources :orders do
      desc '订单信息' do
        success AppAPI::Entities::Order
      end
      params do
        requires :id, type: Integer, desc: '订单ID'
      end
      get ':id' do
        authenticate!
        present current_user.orders.find(params[:id]), with: AppAPI::Entities::Order
      end

      desc "订单创建" do
        success AppAPI::Entities::Order
      end
      params do
        if Settings.project.meikemei?
          requires :product_id, type: Integer, desc: '产品ID'
          requires :service_time, type: String, desc: '服务时间'
          optional :staff_id, type: Integer, desc: '美容师ID'
        else
          requires :site_id, type: Integer, desc: "#{::Site.model_name.human}ID"
          requires :shopping_cart_ids, type: Array[Integer], coerce_with: ->(val) { val.split(/,|，/).map(&:to_i) }, desc: '购物车ID列表'
          optional :address_book_id, type: Integer, desc: '地址薄ID'
        end
      end
      post do
        authenticate!
        if Settings.project.meikemei?
          product = ::Product.find_by(id: params[:product_id])
          error! '产品不存在!' if product.nil?
          order = current_user.orders.new(site_id: product.site_id)
          order.order_products.new(product_id: product.id, price: product.sell_price, amount: 1)
          order.price = product.sell_price
          order.service_time = params[:service_time]
          order.staff_id = params[:staff_id]
          error! order.errors unless order.save
          present order, with: AppAPI::Entities::Order
        else
          site = ::Site.find_by(id: params[:site_id])
          order = current_user.orders.new(site: site)
          shopping_carts = ::ShoppingCart.where(id: params[:shopping_cart_ids])
          error! '购物清单为空！' if shopping_carts.empty?
          shopping_carts.each do |sc|
            order.order_products.new(product_id: sc.product_id, price: sc.price, amount: sc.amount)
          end
          # 这里的修改是因为在order_product的model里面price已经被设置为产品价格和数量的乘积了，不要再改回去了
          # def set_default_price
          #   self.price ||= product.price * amount
          # end
          order.price = order.order_products.map(&:price).sum
          if Settings.project.imolin?
            order.price = order.price + site.delivery_fee.to_f
            order.delivery_fee = site.delivery_fee
          end
          if params[:address_book_id]
            address_book = current_user.address_books.find_by(id: params[:address_book_id])
            unless address_book.blank?
              order.delivery_username = address_book.name
              order.delivery_phone = address_book.mobile_phone
              order.delivery_address = address_book.full_address
            end
          end
          error! order.errors unless order.save && shopping_carts.destroy_all
          present order, with: AppAPI::Entities::Order
        end
      end

      desc "删除订单" do
        success AppAPI::Entities::Order
      end
      params do
        requires :id, type: Integer, desc: '订单ID'
      end
      delete do
        authenticate!
        order = current_user.orders.find(params[:id])
        if order.update_attributes(deleted: true)
          present order, with: AppAPI::Entities::OrderSimple
        else
          error! '删除失败'
        end
      end

      desc '获取订单列表' do
        success AppAPI::Entities::Order.collection
      end
      params do
        use :pagination
        use :sort, fields: [:id, :created_at, :updated_at]
        optional :status, type: String, values: ['open', 'pending', 'paid', 'delivering', 'cancelled', 'completed'], desc: '订单状态：未付款，付款中，已付款，发货中，已取消，已完成'
      end
      get do
        authenticate!
        orders = current_user.orders.undeleted
        if params[:status]
          orders = orders.where(status: params[:status])
        end
        orders = paginate_collection(sort_collection(orders), params)
        wrap_collection orders, AppAPI::Entities::Order
      end

      desc '确认收货'
      params do
        requires :id, type: Integer, desc: '订单ID'
      end
      put do
        authenticate!
        order = current_user.orders.find_by(id: params[:id])
        error! '你没有这个订单' unless order

        if order.completed!
          order.order_products.each do |order_product|
            product = order_product.product
            product.sales_count += order_product.amount
            product.save!
          end
          if Settings.project.meikemei? && order.staff_id
            staff = ::Staff.find(order.staff_id)
            staff.total_service = staff.total_service.to_i + 1
            staff.save!
          end
          present order, with: AppAPI::Entities::Order
        else
          error! '服务器发生错误，请稍后再试'
        end

      end

      desc '创建订单的charge'
      params do
        requires :id, type: Integer, desc: '订单ID'
        requires :channel, type: String, desc: '支付通道'
      end
      post ':id/charge' do
        authenticate!
        order = current_user.orders.find_by(id: params[:id])
        case order.status
        when 'open'
          charge = PaymentCore.create_charge(
            order_no: order.code,
            channel: params[:channel],
            amount: order.price,
            client_ip: env['HTTP_X_REAL_IP'] || env['REMOTE_ADDR'],
            subject: "购买 #{order.order_products.first.product.site.title} 的产品",
            body: order.order_products.map { |op| "#{op.product.name} x #{op.amount}" }.join(';').truncate(128)
          )
          present charge: charge
        when 'paid'
          error! '请勿重复支付！'
        else
          error! '支付失败！'
        end
      end

      desc '订单评论'
      params do
        requires :id, type: Integer, desc: '订单ID'
        requires :content, type: String, desc: '评论或者回复内容'
        optional :parent_id, type: Integer, desc: '如果填写，parent_id就是回复的某条评论的ID'
      end
      post ':id/comments' do
        authenticate!
        order = current_user.orders.find_by(id: params[:id])
        error! '该订单不存在' unless order

        comment_attributes = {}
        comment_attributes[:content]  = params[:content]
        comment_attributes[:parent]   = ::Comment::Entry.where(id: params[:parent_id]).first unless params[:parent_id].blank?
        comment_attributes[:user]     = current_user

        comment = order.comments.new(comment_attributes)
        if comment.save
          present comment, with: AppAPI::Entities::Comment
        else
          error! comment.errors.full_messages.join(', ')
        end
      end

      desc '申请订单退款'
      params do
        requires :id, type: Integer, desc: '订单ID'
        requires :description, type: String, desc: '退款描述'
      end
      post ':id/refund' do
        authenticate!
        order = current_user.orders.find_by(id: params[:id])
        error! '该订单不存在' unless order

        error! '已经在退款流程中' unless order.refund_status.blank?

        order.refund_status = 'apply_refund'
        order.refund_description = params[:description]
        order.apply_refund_by = current_user.id

        message = if order.save
          "退款申请提交成功"
        else
          order.errors.full_messages.join(', ')
        end

        present message: message
      end

    end # end of resources
  end
end
