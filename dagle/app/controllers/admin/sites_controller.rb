class Admin::SitesController < Admin::BaseController
  before_action :set_site, only: [:show, :edit, :update, :destroy]
  before_action :set_delivery_fee, only: [:create, :update]

  def dashboard
    authorize Site
  end

  # GET /admin/sites
  def index
    authorize Site
    @filter_colums = %w(id title address_line)
    @sites = if params[:search] && params[:search][:keywords] =~ /^\d{11}$/
      mobile = User::Mobile.where(phone_number: params[:search][:keywords]).first
      if mobile.present? && mobile.user.present?
        mobile.user.sites.page(params[:page])
      else
        build_query_filter(Site.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
      end
    else
      build_query_filter(Site.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    end
    @sites = @sites.where(is_flatform_recommend: params[:search][:recommend]) if params[:search]&&params[:search][:recommend]
    # @sites = @sites.where("title like ?", "%#{params['q']}%") if params["q"].present?
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@sites.to_json, filename: "products-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@sites.to_xml, filename: "products-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@sites.as_csv(), filename: "sites-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
        format.json { render json: {:results => @sites.select(:id, :title)} }
      end
    end
  end

  # GET /admin/sites/1
  def show
    authorize @site
    #TODO: 查找商家(site)发布的产品, 最新发布排序
    @products = @site.products.order(updated_at: :desc).page(params[:page]) if params[:products]
  end

  # GET /admin/sites/new
  def new
    authorize Site
    @site = Site.new(parent_id: params[:parent_id])
  end

  # GET /admin/sites/1/edit
  def edit
    authorize @site
  end

  # POST /admin/sites
  def create
    authorize Site
    flag, @site = Site::Create.(permitted_attributes(Site).merge(updated_by: current_user.id))
    if flag
      redirect_to admin_site_path(@site), notice: '创建成功.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/sites/1
  def update
    authorize @site
    # if params[:site][:lat].present? &&  params[:site][:lat].present?
      # address = Gnomon::Address.resolve(lat: params[:site][:lat], lng: params[:site][:lng])
      # @site.address = address
      # @site.address_line = address.name if address
      # manual_geo = @site.manual_geo || @site.build_manual_geo
      # manual_geo.lat = params[:site][:lat]
      # manual_geo.lng = params[:site][:lng]
      # manual_geo.save! if manual_geo.changed?
    # end

    flag, @site = Site::Update.(@site, permitted_attributes(@site).merge(updated_by: current_user.id))
    if flag
      redirect_to admin_site_path(@site), notice: '更新成功.'
    else
      render :edit
    end
  end

  # DELETE /admin/sites/1
  def destroy
    authorize @site
    @site.destroy
    redirect_to admin_sites_url, notice: '删除成功.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @site = Site.find(params[:id])
    end

    def set_delivery_fee
      params[:site][:delivery_fee] = params[:site][:delivery_fee].to_f * 100 unless params[:site][:delivery_fee].blank?
    end
    # Only allow a trusted parameter "white list" through.
    # def admin_site_params
    #       #   params.require(:admin_site).permit(policy(@admin_site).permitted_attributes)
    #       # end
end
