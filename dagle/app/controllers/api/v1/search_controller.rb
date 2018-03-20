class Api::V1::SearchController < Api::BaseController
  #before_action :authenticate!

  def index
    # 判断输入的内容, 规则：如果全是数字并且长度为11，就按电话号码查找
    if params[:message] =~ /^\d+$/ && params[:message].size == 11
      user = User.find_by_phone_number(params[:message])
      orders = user.orders
    else
      orders = Order.where(code: params[:message])
    end
    page_size = params[:page_size] ? params[:page_size].to_i : 20
    orders = orders.order("created_at desc").page(params[:page] || 1).per(page_size)
    orders_json = order_json(orders)
    render json: {
      json_data: orders_json,
      page_size: page_size,
      current_page: orders.current_page,
      total_pages: orders.total_pages,
      total_count: orders.total_count
    }
  end

  private
    def order_json(orders)
      orders.as_json(only: [:id, :code, :price, :status, :description, :created_at], include: {site: {only: [:title]}})
    end
end
