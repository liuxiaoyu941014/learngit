class Agent::ProductsController < Agent::BaseController
  before_action :set_current_user_products
  before_action :set_product, only: [:show, :edit, :update, :destroy, :process_shelves, :sales_distribution, :download_signup_members, :orders]
  before_action :set_site_tags, only: [:edit, :new]
  before_action :set_product_price, only: [:create, :update, :index]
  acts_as_trackable user_id: :get_user_id,
    resource: :get_visit_resource,
    only: [:show]
  acts_as_commentable resource: Product

  def index
    authorize Product
    @catalogs = ProductCatalog.roots
    # 搜索查询
    if params[:search].present?
      conditions = []
      query = []
      keywords = params[:search][:keywords]
      price_form = params[:search][:price_from].to_f
      price_to = params[:search][:price_to].to_f
      if !keywords.blank?
        query << "(name like ? or features ->> 'description' like ?)"
        conditions << "%" + keywords + "%"
        conditions << "%" + keywords + "%"
      end
      if price_form > 0
        query << "features -> 'price' >= ?"
        conditions << price_form.inspect
      end
      if price_to > 0
        query << "features -> 'price' <= ?"
        conditions << price_to.inspect
      end
      other_attributes = %w(hot recommend event promotion discount)
      other_attributes.each do |attr|
        if params[:search][attr] == '1'
          query << "features ->> '" + attr + "' like ?"
          conditions << "1"
        end
      end
      conditions.unshift query.join(' and ')
      @products = @site.products.where(conditions)
      if params[:search][:catalog_id].present?
        catalog_id = params[:search][:catalog_id]
      end
    end
    if params[:catalog].present?
      catalog_id = params[:catalog]
    end
    catalog = ProductCatalog.where(id: catalog_id).first
    @products = @products.where(catalog_id: catalog.self_and_descendant_ids) if catalog
    if params[:reorder].present?
      @products = case params[:reorder]
      # when 'clicks'
      #   @products.order(price: :asc)
      when 'newest'
        @products.order(created_at: :desc)
      # when 'discount'
      #   @products.order(price: :asc)
      when 'price'
        @products.order("features -> 'discount' desc")
      else
        @products
      end
    end
    @products = @products.page(params[:page]).per(9)
    respond_to do |format|
      format.html
      format.json { render json: @products }
    end
  end

  def show
    authorize @product
    @catalog_ancestors = []
    if @product.catalog.present?
      @catalog_ancestors.push(@product.catalog)
      if @product.catalog.parent
        @catalog_ancestors = (@catalog_ancestors + @product.catalog.ancestors).reverse
      end
    end
    if @product.purchase_type && @product.purchase_type.include?('sign_up')
      @orders = OrderProduct.where(product_id: @product.id).map{|order_product| order_product.order}
    end
    respond_to do |format|
      format.html
      format.json { render json: @product }
      format.png do
        qrcode = RQRCode::QRCode.new(wechat_orders_micro_website_url(product_id: @product.id))
        send_data qrcode.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 240,
          border_modules: 4,
          module_px_size: 6,
          file: nil
        )
      end
    end
  end

  def new
    authorize Product
    @product = Product.new
    
  end

  def edit
    authorize @product
  end

  def create
    if params[:product][:member_attributes].present? || params[:product][:member_attributes_others].present?
      params[:product][:member_attributes] = params[:product][:member_attributes] + params[:product][:member_attributes_others].split(/,/)
      params[:product][:member_attributes] = params[:product][:member_attributes].delete_if{|ma| ma.blank?}
    end
    @product = Product.new(permitted_attributes(Product))
    @product.site = @site
    authorize @product
    filter_additional_attribute
    filter_add_date
    filter_add_stock
    @product.member_attribute_validates = params[:product][:member_attribute_validates] if params[:product][:member_attribute_validates].present?
    if @product.save
      # redirect_to agent_product_path(@product), notice: 'Product 创建成功.'
      render json: {url: agent_product_path(@product)}
    else
      render json: {errors: @product.errors.full_messages.join(',')}
    end
  end

  def update
    authorize @product
    filter_additional_attribute
    filter_add_date
    filter_add_stock
    if params[:product][:member_attributes].present? || params[:product][:member_attributes_others].present?
      params[:product][:member_attributes] = params[:product][:member_attributes] + params[:product][:member_attributes_others].split(/,/)
      params[:product][:member_attributes] = params[:product][:member_attributes].delete_if{|ma| ma.blank?}
      @product.member_attribute_validates = params[:product][:member_attribute_validates] if params[:product][:member_attribute_validates].present?
    end
    if @product.update(permitted_attributes(@product))
      redirect_to agent_product_path(@product), notice: "#{Product.model_name.human}更新成功."
    else
      render json: {error: '名称已经被使用'}
    end
  end

  def destroy
    authorize @product
    @product.destroy
    respond_to do |format|
      format.html { redirect_to agent_products_url, notice: "#{Product.model_name.human}删除成功." }
      format.json { head 200 }
    end
  end

  def process_shelves
    if @product.update is_shelves: (params[:status] == '1' ? '1' : '0')
      render json: {status: 'ok'}
    end
  end

  def sales_distribution
    resource = SalesDistribution::Resource.find_or_create_by(
      type_name: '产品',
      user: current_user,
      url: agent_product_path(@product),
      object: @product
    )
    render json: {
      code: resource.code,
      share_path: URI(request.scheme + "://" + request.host + ":" + request.port.to_s).merge(resource.share_path).to_s
    }
  end

  def download_signup_members
    if params[:format] == 'csv'
      if @product.purchase_type && @product.purchase_type.include?('sign_up')
        orders = OrderProduct.where(product_id: @product.id).map{|order_product| order_product.order}
        members = orders.map{|o| o.member_attributes}.flatten.compact
      end
      send_data(to_csv(members, @product), filename: "products-members-signup-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv")
    end
  end

  def orders
    @orders_all = @product.orders
    @orders = @orders_all.page(params[:page])
    if params[:format] == 'csv'
      send_data(to_orders_csv(@orders_all), filename: "products-#{@product.id}-orders-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = @products.find(params[:id])
    end

    def set_current_user_products
      @products = @site.products
    end

    def filter_additional_attribute
      if params[:product][:additional_attribute_keys].present?
        params[:product][:additional_attribute_keys].each_pair do |k, v|
          # 这里的意思是只要它的value值是有的那就可以修改成功，但是一旦value为空就把整个这一条信息给删除
          if v.blank?
            params[:product][:additional_attribute_keys].delete(k)
            params[:product][:additional_attribute_values].delete(k)
          end
        end
      end
      if params[:product][:additional_attribute_keys].present?
        @product.additional_attribute_keys = params[:product][:additional_attribute_keys]
        @product.additional_attribute_values = params[:product][:additional_attribute_values]
      end
    end
    
    def filter_add_date
      if params[:product][:date].present?
         params[:product][:date].each_pair do |k, v|
          if v.blank?
            params[:product][:date].delete(k)
            params[:product][:time].delete(k)
          end
        end
      end
      if params[:product][:date].present?
        @product.date = params[:product][:date]
        @product.time = params[:product][:time]
      end
    end

    def filter_add_stock
      if params[:product][:stock].present?
         params[:product][:stock].each_pair do |k, v|
          if v.blank?
            params[:product][:stock].delete(k)
            params[:product][:unit].delete(k)
          end
        end
      end
      if params[:product][:stock].present?
       @product.stock = params[:product][:stock]
       @product.unit = params[:product][:unit]
      end
    end

    def set_site_tags
      @site_tags      = @site.tags.pluck(:name).uniq
      @site_most_tags = @site.tags.most_used(5).uniq.map(&:name)
    end

    def set_product_price
      if params[:product].present?
        params[:product][:price] = params[:product][:price].to_f * 100 unless params[:product][:price].blank?
        params[:product][:discount] = params[:product][:discount].to_f * 100 unless params[:product][:discount].blank?
      end
      if params[:search].present?
        params[:search][:price_from] = params[:search][:price_from].to_f * 100 unless params[:search][:price_from].blank?
        params[:search][:price_to] = params[:search][:price_to].to_f * 100 unless params[:search][:price_to].blank?
      end
    end

    def get_user_id
      current_user && current_user.id
    end

    def get_visit_resource
      @product
    end


    def to_orders_csv(orders)
      return [] if orders.nil?
      # make excel using utf8 to open csv file
      head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join()
      CSV.generate(head) do |csv|
        # 获取字段名称
        column_names = ['产品名称', '订单号', '订单金额', '客户', '状态']
        csv << column_names        
        orders.each do |order|
          values = []
          values << @product.name
          values << order.code
          values << order.price
          values << order.user.nickname
          values << I18n.t("activerecord.attributes.order.statuses.#{order.status}")
          csv << values
        end
      end
    end

    def to_csv(objects, product)
      return [] if objects.nil?
      # make excel using utf8 to open csv file
      head = 'EF BB BF'.split(' ').map{|a|a.hex.chr}.join()
      CSV.generate(head) do |csv|
        # 获取字段名称
        column_names = product.member_attributes.map{|attr| Product::MEMBER_ATTRIBUTES[attr.to_sym] || attr }
        csv << column_names        
        objects.each do |obj|
          values = []
          product.member_attributes.each do |attr|
            values << "\t" + obj[attr]
          end
          csv << values
        end
      end
    end
end
