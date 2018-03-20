class Admin::OrderDeliveriesController < Admin::BaseController

  def index
    authorize OrderDelivery
    @order_deliveries = OrderDelivery.all
    if params[:search] && params[:search][:daterange].present?
      date_range = params[:search][:daterange].split(' - ').map(&:strip).map(&:to_date)
      @order_deliveries = @order_deliveries.where("created_at in (?)", date_range[0]..date_range[-1])
    end
    @orders = Order.all
    if params[:search] && params[:search][:order_code].present?
      @orders = @orders.where("code like ?", "%#{params[:search][:order_code]}%")
    end
    if params[:search] && params[:search][:site_name].present?
      @orders = @orders.joins(:site).where("sites.title like ?", "%#{params[:search][:site_name]}%")
    end
    @order_deliveries = @order_deliveries.where(order_id: @orders).order(updated_at: :desc).page(params[:page])
  end
end
