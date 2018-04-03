# csv support
require 'csv'
class Admin::ProductsController < Admin::BaseController
  before_action :set_products
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :set_site, only: [:new, :edit, :create, :show, :update, :destroy]
  before_action :set_site_tags, only: [:edit, :new]
  before_action :set_product_price, only: [:create, :update]

  def dashboard
    authorize Product
  end

  # GET /admin/products
  def index
    authorize Product
    @filter_colums = %w(id)
    @products = if params[:site_id]
                  @site = Site.find(params[:site_id])
                  @site.products
                else
                  Product.all
                end
    @products = build_query_filter(@products, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@products.to_json, filename: "products-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@products.to_xml, filename: "products-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@products.as_csv(), filename: "products-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/products/1
  def show
    authorize @product
    # @Item = Item.all
  end

  # GET /admin/products/new
  def new
    authorize Product
    @product = Product.new
  
   
  end

  # GET /admin/products/1/edit
  def edit
    authorize @product
  end

  # POST /admin/products
  def create
    authorize Product
    
    @product = Product.new(permitted_attributes(Product).merge(site_id: @site.id))
    filter_additional_attribute
    filter_add_date
    filter_add_stock
    if @product.save
      redirect_to admin_site_product_path(@site, @product), notice: 'Product 创建成功.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/products/1
  def update
    authorize @product
    filter_additional_attribute
    filter_add_date
    filter_add_stock
    if @product.update(permitted_attributes(@product))
      redirect_to admin_site_product_path(@site, @product), notice: 'Product 更新成功.'
    else
      render :edit
    end
  end

  # DELETE /admin/products/1
  def destroy
    authorize @product
    @product.destroy
    redirect_to admin_site_products_url, notice: 'Product 删除成功.'
  end

  private

    def set_products
      if params[:site_id].present?
        @products = Product.where(site_id: params[:site_id])
      else
        @products = Product.all
      end
    end

    def set_product
      @product = @products.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_product_params
    #       #   params.require(:admin_product).permit(policy(@admin_product).permitted_attributes)
    #       # end

    def set_site_tags
      @tags_all = @site.tags.pluck(:name).uniq
      @most_used_tags = @site.tags.most_used(5).uniq.map(&:name) #uniq删除数组中的重复元素后生成新数组并返回它
    end

    def set_site
      @site = Site.find(params[:site_id])
    end

    def filter_additional_attribute
      if params[:product][:additional_attribute_keys].present?
        params[:product][:additional_attribute_keys].each_pair do |k, v|
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
      params[:product][:tag_list] = [] if params[:product][:tag_list].blank?
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
      params[:product][:tag_list] = [] if params[:product][:tag_list].blank?
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

    def set_product_price
      params[:product][:price] = params[:product][:price].to_f * 100 unless params[:product][:price].blank?
      params[:product][:discount] = params[:product][:discount].to_f * 100 unless params[:product][:discount].blank?
    end
end
