class Api::V1::MaterialPurchasesController < Api::BaseController
  before_action :authenticate!
  before_action :set_material_purchase, only: [:update, :show, :audit, :destroy, :update_material]

  def index
    # authorize MaterialPurchase
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    material_purchases =  params[:role].present? ? MaterialPurchase.with_role(params[:role]) : MaterialPurchase.all
    if params["status"].present?
      if ['uncheck', 'checked', 'storage'].include?(params["status"])
        material_purchases = material_purchases.send(params["status"])
      elsif params['status'] == 'unclear'
        material_purchases = material_purchases.where("features ->> 'paid' < features ->> 'total'")
      end
    end
    material_purchases = material_purchases.order(created_at: :desc).page(params[:page] || 1).per(page_size)
    render json: {
      material_purchases: material_purchases_json(material_purchases),
      page_size: page_size,
      current_page: material_purchases.current_page,
      total_pages: material_purchases.total_pages,
      total_count: material_purchases.total_count
    }
  end

  def create
    authorize MaterialPurchase
    flag, material_purchase = MaterialPurchase::Create.(permitted_attributes(MaterialPurchase).merge(created_by: current_user.id))
    if flag
      if params["material_purchase"]["order_material_id"].present?
        order_material_ids = params["material_purchase"]["order_material_id"]
        order_material_ids.each do |id|
          next if id.blank?
          order_material = OrderMaterial.find_by(id: id)
          order_material.purchased!
        end
      end
      render json: {status: 'ok', material_purchase: material_purchase_json(material_purchase)}
    else
      render json: {status: 'failed', error_message:  material_purchase.errors.full_messages.join(', ') }
    end
  end


  def update
    authorize @material_purchase
    flag = true
    material_purchase = nil
    messages = []
    MaterialPurchase.transaction do
      # 物料入库
      if params["material_management"]
        import_flag, import_record = process_material_purchase_import
        messages.push(import_record.errors.full_messages.join(', '))
        flag = flag && import_flag
      end
      # 更新付款信息及财务流水
      if params[:material_purchase][:paying].present?
        @material_purchase.paid = @material_purchase.paid.to_f + params[:material_purchase][:paying].to_f
        finance_flag, finance_history = FinanceHistory::Create.(operate_type: 'out', operate_date: Date.today, amount: params[:material_purchase][:paying], owner: @material_purchase)
        messages.push(finance_history.errors.full_messages.join(', '))
        flag = flag && finance_flag
      end
      # 更新采购信息
      purchase_flag, material_purchase = MaterialPurchase::Update.(@material_purchase, permitted_attributes(@material_purchase))
      messages.push(material_purchase.errors.full_messages.join(', '))

      material_purchase.storage! if flag && material_purchase.material_purchase_details.detect{|mpd| mpd.number != mpd.input_number}.nil?

      flag = flag && purchase_flag
      raise ActiveRecord::Rollback unless flag
    end
    if flag
      render json: {status: 'ok', material_purchase: material_purchase_json(material_purchase)}
    else
      render json: {status: 'failed', error_message:  messages.compact.join('.') }
    end
  end
  

  # def update
  #   authorize @material_purchase
  #   import_flag = true
  #   if params["material_management"]
  #     import_flag, import_record = process_material_purchase_import
  #   end
  #   if import_flag
  #     if params[:material_purchase][:paying].present?
  #       @material_purchase.paid = @material_purchase.paid.to_f + params[:material_purchase][:paying].to_f
  #       finance_history = FinanceHistory.new(operate_type: 'out', operate_date: Date.today, amount: params[:material_purchase][:paying], owner: @material_purchase)
  #     end
  #     flag, material_purchase = MaterialPurchase::Update.(@material_purchase, permitted_attributes(@material_purchase))
  #     if flag && finance_history.save
  #       render json: {status: 'ok', material_purchase: material_purchase_json(material_purchase)}
  #     else
  #       render json: {status: 'failed', error_message:  material_purchase.errors.full_messages.join(', ') }
  #     end
  #   else
  #     render json: {status: 'failed', error_message:  import_record.errors.full_messages.join(', ') }
  #   end
  # end

  def destroy
    authorize @material_purchase
    if @material_purchase.destroy
      render json: {status: 'ok'}
    else
      render json: {status: 'failed', error_message: '出错了!'}
    end
  end

  def show
    # authorize @material_purchase
    render json: {status: 'ok', material_purchase: material_purchase_json(@material_purchase)}
  end

  def update_material
    authorize @material_purchase
    success = true
    material_purchase_detail = @material_purchase.material_purchase_details.find_or_create_by(material_id: params["material"]["material_id"])
    if material_purchase_detail.new_record?
      material_purchase_detail.price = params["material"]["price"]
      material_purchase_detail.number = params["material"]["amount"]
      success &= material_purchase_detail.save
      if success
        amount = @material_purchase.amount.to_f
        @material_purchase.amount = amount + (material_purchase_detail.price.to_f * material_purchase_detail.number.to_i)
        @material_purchase.total += material_purchase_detail.number
        success &= @material_purchase.save
      end
      if success
        render json: {status: 'ok'}
      else
        render json: {status: 'failed', error_message: material_purchase_detail.errors.full_messages.join(', ')}
      end
    else
      render json: {status: 'failed', error_message: '物料已存在！'}
    end
  end

  def audit
    authorize @material_purchase
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    audits = @material_purchase.audits.order(created_at: :desc).page(params[:page] || 1).per(page_size)
    render json: {
      audits: audits_json(audits),
      detail_audits: detail_audits_json(@material_purchase.associated_audits),
      destory_materials: Material.where(id: @material_purchase.associated_audits.where(action: 'destroy').map{|a| a.audited_changes["material_id"]}).as_json(only: %w(id name)),
      page_size: page_size,
      current_page: audits.current_page,
      total_pages: audits.total_pages,
      total_count: audits.total_count
    }
  end

  private

  def material_purchases_json(material_purchases)
    material_purchases.as_json(
      only: %w(id vendor_id status),
      methods: %w(code purchase_date amount total paid),
      include: {
        vendor: {
          only: %w(id name),
          methods: %w(contact_name phone_number)
        }
      }
    )
  end

  def material_purchase_json(material_purchase)
    material_purchase.as_json(
      only: %w(id vendor_id status created_by),
      methods: %w(code purchase_date amount total paid delivery_date),
      include: {
        vendor: {
          only: %w(id name),
          methods: %w(contact_name phone_number)
        },
        user: {
          only: %w(id nickname)
        },
        material_purchase_details: {
          only: %w(id material_id price number input_number),
          include: {
            material: {
              only: %w(id name name_py)
            }
          }
        }
      }
    )
  end

  def audits_json(audits)
    audits.as_json(
      only: %w(id action audited_changes created_at),
      include: {
        user: {
          only: %w(nickname)
        }
      }
    )
  end

  def detail_audits_json(audits)
    audits.as_json(
      only: %w(id action audited_changes created_at),
      include: {
        user: {
          only: %w(nickname)
        },
        auditable: {
          only: [],
          include: {
            material: {
              only: %w(name)
            }
          }
        }
      }
    )
  end

  def set_material_purchase
    @material_purchase = MaterialPurchase.find(params[:id])
  end

  def process_material_purchase_import
    MaterialManagement::Create.(permitted_attributes(MaterialManagement).merge({created_by: current_user.nickname}))
  end
end
