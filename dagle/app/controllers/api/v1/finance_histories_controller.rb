# 财务流水
class Api::V1::FinanceHistoriesController < Api::V1::BaseController
  before_action :authenticate!
  # 财务流水列表
  # @param [Integer] page 页码
  # @param [Integer] page_size 每页显示数据
  # @return [JSON]
  def index
    operate_type = params[:operate_type]
    if ['in', 'out'].include?(operate_type) 
      page_size = params[:page_size].present? ? params[:page_size].to_i : 20
      finance_histories = FinanceHistory.send(operate_type)
      if operate_type == 'in'
        orders = Order.where("code like :key", {key: ['%',params['code'].upcase, '%'].join}) if params[:code]
        finance_histories = finance_histories.where(owner: orders) if orders.any?
      else
        purchases = MaterialPurchase.where("code like :key", {key: ['%',params['code'].upcase, '%'].join}) if params[:code]
        finance_histories = finance_histories.where(owner: purchases) if purchases.any?
      end
      finance_histories = finance_histories.order(created_at: :desc).page(params[:page] || 1).per(page_size)
      render json: {
        finance_histories: operate_type == 'in' ? order_finance_json(finance_histories) : purchase_finance_json(finance_histories),
        page_size: page_size,
        current_page: finance_histories.current_page,
        total_pages: finance_histories.total_pages,
        total_count: finance_histories.total_count
      }
    else
      render json: {status: 'failed', message: '页面不存在'}
    end
  end

  def create
    authorize FinanceHistory
    owner = nil
    if params[:finance_history] && params[:finance_history][:order_id].present?
      owner = Order.find(params[:finance_history][:order_id])
    else
      # to do purchase
    end
    flag, finance = FinanceHistory::Create.(permitted_attributes(FinanceHistory).merge(owner: owner))
    if flag
      render json: {status: 'ok', finance: order_finance_json(finance)}
    else
      render json: {status: 'failed', error_message:  finance.errors.full_messages.join(', ')}
    end
  end

  private

  def order_finance_json(finance_histories)
    finance_histories.as_json(
      only: [:id, :operate_type, :operate_date, :amount, :note],
      methods: [:image_url],
      include: {
        owner: {
          only: [:id, :code, :price],
          methods: [:paid_status, :paid]
        }
      }
    )
  end

  def purchase_finance_json(finance_histories)
    finance_histories.as_json(
      only: [:id, :operate_type, :operate_date, :amount, :note],
      include: {
        owner: {
          only: [:id, :code, :status],
          methods: [:amount, :paid]
        }
      }
    )
  end
  
end
