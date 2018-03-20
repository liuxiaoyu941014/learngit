class Frontend::SitesController < Frontend::BaseController
	acts_as_commentable resource: Site
  impressionist :actions=>[:show]
  acts_as_trackable user_id: :get_user_id, resource: :get_visit_resource, only: [:show]

  def show
    @site = Site.find(params[:id])
    @comment_path = comments_frontend_site_path(@site)
  end

  private
    def get_user_id
      current_user && current_user.id
    end

    def get_visit_resource
      @site
    end

end
