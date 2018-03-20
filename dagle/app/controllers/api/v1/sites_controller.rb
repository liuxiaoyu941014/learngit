class Api::V1::SitesController < Api::BaseController
  before_action :authenticate!

  def index
    # authorize Site
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    sites = params['name'].present? ? Site.where("title like :key", {key: ['%',params['name'], '%'].join}) : Site.all
    sites = sites.order(created_at: :desc).page(params[:page] || 1).per(page_size)
    render json: {
      sites: site_json(sites),
      page_size: page_size,
      current_page: sites.current_page,
      total_pages: sites.total_pages,
      total_count: sites.total_count
    }
  end

  private
  def site_json(sites)
    sites.as_json(only: [:id, :title])
  end

end
