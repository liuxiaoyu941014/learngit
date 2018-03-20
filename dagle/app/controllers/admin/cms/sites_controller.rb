# csv support
require 'csv'
class Admin::Cms::SitesController < Admin::Cms::BaseController
  before_action :set_cms_site, only: [:show, :edit, :update, :destroy]

  # GET /admin/cms/sites
  def index
    authorize ::Cms::Site
    @filter_colums = %w(name)

    @cms_sites = build_query_filter(::Cms::Site.all, only: @filter_colums).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@cms_sites.to_json, filename: "cms_sites-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@cms_sites.to_xml, filename: "cms_sites-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@cms_sites.as_csv(only: []), filename: "cms_sites-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/cms/sites/1
  def show
    authorize @cms_site
  end

  # GET /admin/cms/sites/new
  def new
    authorize ::Cms::Site
    @cms_site = ::Cms::Site.new
  end

  # GET /admin/cms/sites/1/edit
  def edit
    authorize @cms_site
  end

  # POST /admin/cms/sites
  def create
    authorize ::Cms::Site
    @cms_site = ::Cms::Site.new(permitted_attributes(::Cms::Site))

    if @cms_site.save
      redirect_to admin_cms_site_path(@cms_site), notice: "#{::Cms::Site.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/cms/sites/1
  def update
    authorize @cms_site
    if @cms_site.update(permitted_attributes(@cms_site))
      redirect_to admin_cms_site_path(@cms_site), notice: "#{::Cms::Site.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/cms/sites/1
  def destroy
    authorize @cms_site
    @cms_site.destroy
    redirect_to admin_cms_sites_url, notice: "#{::Cms::Site.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_site
      @cms_site = ::Cms::Site.find(params[:id])
    end
end
