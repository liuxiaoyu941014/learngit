# csv support
require 'csv'
class Admin::Cms::PagesController < Admin::Cms::BaseController
  before_action :set_site_and_channel
  before_action :set_cms_page, only: [:show, :edit, :update, :destroy]

  # GET /admin/cms/pages
  def index
    authorize ::Cms::Page
    @filter_colums = %w(title)
    @cms_pages = build_query_filter(::Cms::Page.joins(:channel).where("cms_channels.site_id = ?", @cms_site.id), only: @filter_colums).reorder("updated_at DESC").page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@cms_pages.to_json, filename: "cms_pages-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@cms_pages.to_xml, filename: "cms_pages-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@cms_pages.as_csv(only: []), filename: "cms_pages-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/cms/pages/1
  def show
    authorize @cms_page
  end

  # GET /admin/cms/pages/new
  def new
    authorize ::Cms::Page
    @cms_page = ::Cms::Page.new
  end

  # GET /admin/cms/pages/1/edit
  def edit
    authorize @cms_page
  end

  # POST /admin/cms/pages
  def create
    authorize ::Cms::Page
    @cms_page = ::Cms::Page.new(permitted_attributes(::Cms::Page))

    if @cms_page.save
      redirect_to admin_cms_site_pages_path(@cms_site), notice: "#{::Cms::Page.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/cms/pages/1
  def update
    authorize @cms_page
    if @cms_page.update(permitted_attributes(@cms_page))
      redirect_to admin_cms_site_pages_path(@cms_site), notice: "#{::Cms::Page.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/cms/pages/1
  def destroy
    authorize @cms_page
    @cms_page.destroy
    redirect_to admin_cms_site_pages_url(@cms_site), notice: "#{::Cms::Page.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_page
      @cms_page = ::Cms::Page.find(params[:id])
    end

    def set_site_and_channel
      @cms_site = ::Cms::Site.find(params[:site_id])
      @cms_channel = @cms_site.channels.find(params[:channel_id]) if params[:channel_id]
    end
end
