class Cms::SitesController < Cms::BaseController
  before_action :set_cms_site, only: [:show, :edit, :update, :destroy]

  def index
    authorize Cms::Site
  end

  def show
    authorize @cms_site
    @cms_channels = @cms_site.channels.where("parent_id is null").order("id ASC")
    respond_to do |format|
      format.html
      format.json { render json: @cms_site }
    end
  end

  def new
    authorize Cms::Site
    @cms_site = Cms::Site.new
  end

  def edit
    authorize @cms_site
  end

  def create
    @cms_site = Cms::Site.new(permitted_attributes(Cms::Site))
    @cms_site.site_id = @site.id
    authorize @cms_site

    respond_to do |format|
      format.html do
        if @cms_site.save
          redirect_to cms_site_path(@cms_site), notice: '站点创建成功.'
        else
          render :new
        end
      end
      format.json { render json: @cms_site }
    end

  end

  def update
    authorize @cms_site
    respond_to do |format|
      format.html do
        if @cms_site.update(permitted_attributes(@cms_site))
          redirect_to cms_site_path(@cms_site), notice: '站点更新成功.'
        else
          render :edit
        end
      end
      format.json { render json: @cms_site }
    end
  end

  def destroy
    authorize @cms_site
    # destroy site is dangers, just let it hidden
    #@cms_site.destroy
    @cms_site.is_published = false
    @cms_site.save!

    respond_to do |format|
      format.html { redirect_to cms_sites_url, notice: '在未审核之前我们不能删除您的站点，但是已经为你取消了站点发布.' }
      format.json { head 200 }
    end
  end

  private
    # @cms_site is initialized in application_controller.rb#check_subdomain!
    def set_cms_site
      @cms_site = Cms::Site.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def cms_site_params
    #       #   params.require(:cms_site).permit(:name, :template, :domain, :description, :is_published)
    #       # end
end
