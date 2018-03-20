class Frontend::SiteCatalogsController < Frontend::BaseController
  before_action :get_catalogs

  def index
  end

  def show
    @site_catalog =SiteCatalog.find(params[:id])
    # 当前分类下的所有场馆
    @sites = @site_catalog.sites
    # 发布的所有商家
    @sites = @sites.where("features ->> 'is_published' = ?", '1').order(updated_at: :desc).page(params[:page])
  end


  private

  def get_catalogs
    @site_catalogs = SiteCatalog.all
  end

end
