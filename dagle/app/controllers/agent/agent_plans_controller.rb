class Agent::AgentPlansController < Agent::BaseController

  def index
    # authorize AgentPlan
    authorize Product
    # @agent_plans = AgentPlan.all.order("id").page(params[:page])
    catalog = ProductCatalog.where(name: '商家套餐').first
    @agent_plans = Product.where(site_id: Site::MAIN_ID, catalog_id: catalog.try(:id))
    respond_to do |format|
      format.html
      format.json { render json: @agent_plans }
    end
  end

  def charge
    @agent_plan = Product.find(params[:id])
    order = Order.new(
      user_id: @site.user.id,
      site_id: @agent_plan.site_id,
      price: @agent_plan.price
    )
    order.order_products.new(product_id: @agent_plan.id, amount: 1, price: @agent_plan.price)
    order.save!
    callback_url = URI(Settings.site.host)
    options = 'agent/agent_plans/' + @agent_plan.id.to_s + '/paid_success'
    json = PaymentCore.create_charge(
      order_no: order.code, # 订单号
      channel: 'alipay_pc_direct', # 支付宝电脑端网页支付
      amount: order.price, # 1分钱
      client_ip: request.remote_addr,
      subject: "商家#{@site.id}购买套餐",
      body: @agent_plan.name,
      extra: {
        success_url: callback_url.merge(options).to_s
      }
    )
    render js: <<-JS
    onStartCharging('#{json.to_json}')
    JS
  end

  #{
  #   "body"=>"体验套餐C 100元 ch_SqvjHSPybrH4H800eTOmP8mT", 
  #   "buyer_email"=>"18583253953", 
  #   "buyer_id"=>"2088122545949982", 
  #   "exterface"=>"create_direct_pay_by_user", 
  #   "is_success"=>"T", 
  #   "notify_id"=>"RqPnCoPT3K9%2Fvwbh3InYwet%2BoemIn1k2R5h2G7FZZr%2FEeHLhclP0j9LWMY1tvxEV27Y5", 
  #   "notify_time"=>"2017-06-27 10:56:44",
  #   "notify_type"=>"trade_status_sync", 
  #   "out_trade_no"=>"20170627006", 
  #   "payment_type"=>"1", 
  #   "seller_email"=>"kxiu@gangsh.com", 
  #   "seller_id"=>"2088911524084206", 
  #   "subject"=>"商家26购买套餐", 
  #   "total_fee"=>"0.10", 
  #   "trade_no"=>"2017062721001004980258024066", 
  #   "trade_status"=>"TRADE_SUCCESS",
  #   "sign"=>"geRKvUhgqW4VujARGl/M23IfzfkswMw9V4+57Lf+Sqqhgt2nvRvwsDvGAxzGsa61Buk+x9ZFY2G396Z96CDreFVcux8UviXbmUQSXOM5V9wrtVL4bt9HHdt76CSepL4TATP1JX6QRVyJzi1zypQGqepM/oPYR6ENcNKzfguzw3M=", 
  #   "sign_type"=>"RSA", 
  #   "controller"=>"agent/agent_plans", 
  #   "action"=>"paid_success", 
  # }
  def paid_success
    order = Order.find_by_code(params[:out_trade_no])
    # order.build_charge(
    #   channel: params[:exterface],
    #   transaction_no: params[:trade_no]
    # )
    # order.status = 'paid'
    # order.save!
    # @agent_plan = AgentPlan.find(params[:id])
    @site.agent_plan_id = order.order_products.first.product_id
    @site.paid_at = Time.now
    @site.save!
    FinanceBill.create({
      amount: order.price,
      is_entry: true,
      status: 'cashed',
      site_id: @site.id
    })
    redirect_to agent_finance_bills_path
  end
end
