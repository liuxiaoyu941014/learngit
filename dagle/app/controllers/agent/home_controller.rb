class Agent::HomeController < Agent::BaseController
  skip_before_action :set_current_site

  def index
    @site = Site.find_by(user_id: current_user.id)
    if @site.nil?
      redirect_to new_agent_site_path and return
    end
    @preorder_conversition_total_count = @site.preorder_conversitions.count
    @product_total_count = @site.products.count
    @order_total_count = @site.orders.count
    @deliveries_total_count = @site.deliveries.count
  end
end
