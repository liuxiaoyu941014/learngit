class Api::V1::OrdersController < Api::V1::BaseController
  before_action :authenticate!
  before_action :set_orders, only: [:index]
  before_action :set_order, only: [:show, :update, :update_code]

  def index
    # authorize Order
    page_size = params[:page_size] ? params[:page_size].to_i : 20
    orders = params['search_content'].blank? ? @orders : @orders.where("code like :key", {key: ['%',params['search_content'].upcase, '%'].join})
    orders = orders.order(status: :asc, updated_at: :desc).page(params[:page] || 1).per(page_size)
    orders_json = order_json(orders)
    render json: render_base_data(orders_json, orders, page_size, @order_list_type)
  end

  def create
    authorize Order
    flag = false
    order = nil
    finance = nil
    Order.transaction do
      flag, order = Order::Create.(permitted_attributes(Order).merge({create_by: current_user.id}))
      if params[:order][:deposit].to_i > 0
        finance_flag, finance = FinanceHistory::Create.(operate_date: Date.today, amount: params[:order][:deposit], operate_type: 'in', owner: order, created_by: current_user.id)
        flag = flag && finance_flag
      end
      raise ActiveRecord::Rollback unless flag
    end
    if flag
      render json: {status: 'ok', order: order_json(order)}
    else
      # order.errors.messages.delete(:member)
      render json: {status: 'failed', error_message:  order.errors.full_messages.join(', ')  + '.' +  (finance ? finance.errors.full_messages.join(',') : '')}
    end
  end

  def show
    render json: {status: 'ok', order: order_json(@order)}
  end

  def update
    authorize @order
    if @order.update(permitted_attributes(Order))
      if ['packed'].include?(@order.internal_status)
        if sms_site(@order.site.user.mobile.phone_number, @order.code, enum_l(@order, :internal_status))
          sms_message = '已经用短信提示对方现在的订单状态'
        else
          sms_message = '短信提示发送失败'
        end
      end
      render json: {status: 'ok', order: order_json(@order), sms_message: sms_message}
    else
      render json: {status: 'failed', error_message:  @order.errors.full_messages.join(', ') }
    end
  end

  def update_code
    authorize @order
    if @order.update_attributes(code: params[:order][:code])
      render json: {status: 'ok'}
    else
      render json: {status: 'failed', error_message:  @order.errors.full_messages.join(', ') }
    end
  end

  def set_resource_url
    order = Order.find(params[:id])
    if order.update(resource_url: params[:resource_url])
      render json: {status: 'ok'}
    else
      render json: {status: 'error'}
    end
  end

  # def create_comment
  #   authorize Order
  #   order_comment = @order.comments.new(params[:comment].permit(:content, :offer, :image_item_ids => [], :attachment_ids => []))
  #   order_comment.user = current_user
  #   if order_comment.save
  #     render json: {status: 'ok', comment: order_comment_json(order_comment)}
  #   else
  #     render json: {status: 'failed', error_message: 'failed'}
  #   end
  # end

  # def comments_index
  #   page_size = params[:page_size] ? params[:page_size].to_i : 20
  #   order_comments = @order.comments.order(created_at: :asc).page(params[:page] || 1).per(page_size)
  #   render json: {comments: order_comment_json(order_comments), current_page: order_comments.current_page, total_pages: order_comments.total_pages, total_count: order_comments.total_count}
  # end

  private

    def set_orders
      @order_list_type = params[:order_list_type]
      @orders = case @order_list_type
      when 'processing'
        Order.processing
      when 'cancelled'
        Order.cancelled
      when 'completed'
        Order.completed
      else
        Order.all
      end
    end

    def order_json(orders)
      orders.as_json(
        only: [:id, :code, :resource_url, :price, :status, :internal_status, :description, :created_at, :delivery_date],
        include: {
          site: {only: [:id, :title], include: { user: { only: [:nickname], include: { mobile: { only: [:phone_number] } } } }},
          member: {only: [:name]},
          produce: {only: [:id]},
          create_user: {only: [:id, :nickname]},
          update_user: {only: [:id, :nickname]},
          attachments: {only: [:id], methods: [:attachment_url, :attachment_file_name, :attachment_content_type]},
          order_materials: {
            only: [:id, :amount, :factory_expected_number, :practical_number, :material_id],
            include: {
              material: {
                only: [:id, :name, :name_py],
                methods: [:stock],
                include: {
                  material_warehouse_items: { only: %w(material_warehouse_id stock)}
                }
              }
            }
          }
        }
      )
    end

    def set_order
      @order = Order.find(params[:id])
    end

    # def order_comment_json(comment)
    #   comment.as_json(
    #     only: [:content, :created_at], methods: [:offer],
    #     include: {
    #       user: {only: [:nickname]},
    #       image_items: {only: [:id], methods: [:image_url, :image_file_name]},
    #       attachments: {only: [:id, :name], methods: [:attachment_url, :attachment_file_name]}
    #     }
    #   )
    # end
end
