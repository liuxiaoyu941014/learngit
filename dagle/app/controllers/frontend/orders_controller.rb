class Frontend::OrdersController < Frontend::BaseController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :confirm, :refund]
  before_action :ensure_login!

  def index
    @orders = Order.all.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @orders }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def new
    redirect_to binding_phone_users_url(return_url: new_frontend_order_url(product_id: params[:product_id])) unless current_user.try(:mobile).try(:phone_number)
    @order = Order.new
    @product = Product.find(params[:product_id])
   
  end

  def edit
  end

  def create
    ActiveRecord::Base.transaction do
      price = 0
      params[:order][:order_products].each do |order_product|
        price += order_product[:price].to_f
      end
      @frontend_order = Order.new
      @frontend_order.user_id = current_user.id
      @frontend_order.site_id = @site.id
      @frontend_order.price = price
      @frontend_order.description = params[:order][:description]
      @frontend_order.create_by = current_user.id
      @frontend_order.save!
      params[:order][:order_products].each do |order_product_params|
        order_product = @frontend_order.order_products.build
        order_product.product_id = order_product_params[:id]
        order_product.amount = order_product_params[:amount]
        order_product.price = order_product_params[:price]
       
        order_product.save!
      end
    end
    respond_to do |format|
      format.html do
        if @frontend_order
          redirect_to frontend_order_path(@frontend_order), notice: '订单创建成功.'
        else
          render :new
        end
      end
      format.json { render json: @frontend_order }
    end
  end

  def update
    respond_to do |format|
      format.html do
        if @order.update(permitted_attributes(@order))
          redirect_to frontend_order_path(@order), notice: 'Order 更新成功.'
        else
          render :edit
        end
      end
      format.json { render json: @order }
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to frontend_orders_url, notice: 'Order 删除成功.' }
      format.json { head 200 }
    end

  end

  def charge
    if params[:order_id]
      order = Order.find(params[:order_id])
      product = order.order_products.first.product
    else
      order = Order.new(user: current_user)
      product = Product.find(params[:order][:product][:id])
      product_amount = params[:order][:product][:number].presence || 1

      # 是否在预售期内
      if product.reserve_datetime.present? && product.reserve_datetime.to_time.to_i > Time.now.to_i 
        order.errors.add 'order_reserve_datetime'.to_sym, '还未开始发售!'
        render js: <<-JS
          onOrderCreate('#{order.errors.messages.to_json}')
        JS
        return
      end

      if params[:order][:member_attributes].present?
        if product.purchase_type && product.purchase_type.include?("sign_up")
          order.member_attributes = params[:order][:member_attributes].values
          product_amount =  params[:order][:member_attributes].keys.count
          unless valid_order_members?(order)
            render js: <<-JS
            onOrderCreate('#{order.errors.messages.to_json}')
            JS
            return
          end
        end
      end

      # 产品库存是否满足 
      
      if params[:order][:kucun].to_i< product_amount.to_i
        order.errors.add 'order_product_stock'.to_sym, "剩余座位#{product.stock}个!"
        render js: <<-JS
          onOrderCreate('#{order.errors.messages.to_json}')
        JS
        return
      end
      order.order_products.new(product_id: product.id, amount: product_amount, price: product.sell_price)
      order.delivery_phone = params[:order][:delivery_phone] if params[:order][:delivery_phone].present?
      order.site = product.site
      order.price = product.sell_price.to_f * product_amount.to_i
      order.save!
    end

    if order.price == 0
      order.paid!
      render js: <<-JS
      onOrderCreate('#{{redirect_url: frontend_order_url(order)}.to_json}')
      JS
      return
    end
    # 产品库存是否满足
    if params[:order][:kucun].to_i < order.order_products.where(product_id: product.id).map(&:amount).sum()
      order.errors.add 'order_product_stock'.to_sym, "剩余座位#{product.stock}个!"
      render js: <<-JS
        onOrderCreate('#{order.errors.messages.to_json}')
      JS
      return
    end
    pay_channel =  wechat_device? ? 'wx_pub' : 'alipay_pc_direct'
    callback_url = URI(Settings.site.host)
    options = 'frontend/orders/' + order.id.to_s + '/paid_success'
    json = PaymentCore.create_charge(
      order_no: order.code, # 订单号
      # channel: 'alipay_pc_direct', # 支付宝电脑端网页支付
      channel: pay_channel, #微信公众号支付 || 支付宝电脑端网页支付
      amount: order.price, # 1分钱
      client_ip: request.remote_addr,
      subject: "购买#{product.name.truncate(20)}",
      body: product.name,
      extra: {
        success_url: callback_url.merge(options).to_s,
        open_id: current_user.weixin.try(:uid)
      }
    )
    render js: <<-JS
    onStartCharging('#{json.to_json}')
    JS
  end

  def paid_success
    order_status = if params[:is_success] == 'T'
      'paid'
    end
    order = Order.find_by_code(params[:out_trade_no])
    if order.present?
      order.update(status: order_status)
    end
    redirect_to frontend_order_path(order)
  end

  #实现客户端订单查询
  #订单查询页面
  def search
  end
  #post
  #params: mobile/order_id
  def do_search
    if params[:keywords].blank?
      render :search
    else
      redirect_to search_result_frontend_orders_path(keywords: params[:keywords])
    end
  end
  #订单显示页面
  def search_result
    user = nil
    if params[:keywords] =~ /^\d{11}$/
      mobile = User::Mobile.where(phone_number: params[:keywords])
      user = mobile.first.user unless mobile.blank?
    end

    @orders = if user.present?
      user.orders
    else
      Order.where(code: params[:keywords])
    end

    @orders =  @orders.page(params[:page]).per(6)

    if @orders.blank?
      redirect_to search_frontend_orders_path, notice: '未找到该订单号/手机号的订单信息，请重新输入'
    end

  end

  def confirm
    @order.completed!
    @order.order_products.each do |order_product|
      product = order_product.product
      product.sales_count += order_product.amount
      product.save!
      if product.purchase_type && product.purchase_type.include?('sign_up')
        add_members(@order)
      end
    end
    redirect_to frontend_order_path(@order)
  end

  def refund
    if @order.refund_status.blank?
      @order.refund_status = 'apply_refund'
      @order.refund_description = "用户申请退款"
      @order.apply_refund_by = current_user.id
      @order.save!
    end
    redirect_to frontend_order_path(@order)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    
    end

    # Only allow a trusted parameter "white list" through.
    def order_params
      params.require(:order).permit(:user_id, :product_id, :price, :status)
    end

    def ensure_login!
      redirect_to admin_sign_in_path unless current_user
    end

    def valid_order_members?(order)
      flag = true
      product = Product.find_by(id: params[:order][:product][:id])
      order_member_attributes = params[:order][:member_attributes]

      Product::MEMBER_ATTRIBUTES.keys.each do |pma|
        attrs = order_member_attributes.values.map{|oma| oma[pma]}
        validates = product.member_attribute_validates[pma.to_s] if product.member_attribute_validates
        if validates && validates.include?('uniqueness') && attrs.compact.uniq!
          flag = false
          order.errors.add 'order_account_signup'.to_sym, "#{Product::MEMBER_ATTRIBUTES[pma]}重复了,请检查!"
          break
        end
      end

      return flag unless flag

      if order_member_attributes.keys.count == 0
        flag = false
        order.errors.add 'order_account_signup'.to_sym, "至少填写一个名额!"
        return
      end

      one_account_orders = Order.joins(:order_products).where(user_id: current_user.id, status: ['paid', 'completed']).where("order_products.product_id = ?", product.id)
      if product.maximum_for_one_account.to_i < one_account_orders.count
        order.errors.add 'order_account_signup'.to_sym, "一个账户最多定#{product.maximum_for_one_account}次!"
        flag = false
        return flag
      end
      if product.maximum_for_one_order.to_i < order_member_attributes.keys.count
        order.errors.add 'order_account_signup'.to_sym, "一个订单最多定#{product.maximum_for_one_order}个!"
        flag = false
        return flag
      end
      order_member_attributes.each_pair do |key, value|
        order_member = OrderMember.new(order_member_attributes[key])
        flag &&= order_member.valid?
        unless order_member.valid?
          order.errors.add "member_attributes_#{key}".to_sym, order_member.errors.messages
        end
      end
      flag
    end

    def add_members(order)
      site = order.site
      order.member_attributes.each do |oma|
        member = Member.new(site: site)
        member.name = oma["name"]
        member.mobile_phone = oma["mobile"]
        member.card_id = oma["card_id"]
        member.features = member.features.merge(oma.slice!("name", "mobile", "card_id", "product_id"))
        member.save
      end
    end
end
