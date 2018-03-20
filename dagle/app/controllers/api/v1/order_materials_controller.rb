class Api::V1::OrderMaterialsController < Api::BaseController
  before_action :authenticate!
  before_action :set_order, only: [:index, :create]

  def index
    order_materials = @order.order_materials
    render json: order_materials_json(order_materials)
  end

  def create
    authorize OrderMaterial
    order_material = @order.order_materials.where(material_id: params[:order_material][:material_id]).first
    if order_material
      order_material.amount += params[:order_material][:amount] if params[:order_material][:amount].present?
      order_material.factory_expected_number = params[:order_material][:factory_expected_number] if params[:order_material][:factory_expected_number].present?
    else
      order_material = @order.order_materials.new(permitted_attributes(OrderMaterial))
    end
    if order_material.save
      render json: {status: 'ok', order_material: order_materials_json(order_material)}
    else
      render json: {status: 'failed', error_message:  order_material.errors.full_messages }
    end
  end

  def update
    authorize OrderMaterial
    order_material = OrderMaterial.find(params[:id])
    authorize order_material
    if permitted_attributes(OrderMaterial).any? && order_material.update(permitted_attributes(OrderMaterial))
      render json: {status: 'ok', order_material: order_materials_json(order_material)}
    else
      error_message = permitted_attributes(OrderMaterial).any? ? order_material.errors.full_messages : '没有权限'
      render json: {status: 'failed', error_message: error_message}
    end
  end

  def destroy
    authorize OrderMaterial
    OrderMaterial.find(params[:id]).destroy
    render json: {status: 'ok'}
  end

  def need_purchase
    orders = Order.producing
    order_materials = orders.map{|o| o.order_materials.purchasing}.flatten
    render json: {status: 'ok', order_materials: order_materials_json(order_materials)}
  end

  private
    def set_order
      @order = Order.find(params[:order_id])
    end

    def order_materials_json(order_materials)
      order_materials.as_json(only: [:id, :amount, :factory_expected_number, :practical_number],
        include: {
          material: { only: [:id, :name, :name_py], methods: [:price, :stock] }
        }
      )
    end
end
