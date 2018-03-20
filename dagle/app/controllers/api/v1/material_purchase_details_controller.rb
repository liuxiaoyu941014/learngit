# 物料管理

class Api::V1::MaterialPurchaseDetailsController < Api::V1::BaseController
  before_action :authenticate!

  def destroy
    material_purchase_detail = MaterialPurchaseDetail.find(params[:id])
    authorize material_purchase_detail
    material_purchase = material_purchase_detail.material_purchase
    if material_purchase.material_purchase_details.count > 1
      MaterialPurchaseDetail::Destroy.(material_purchase_detail)
      render json: {status: 'ok', material_purchase: material_purchase_json(material_purchase_detail.material_purchase)}
    else
      render json: {status: 'failed', error_message: '无法删除该物料，物料清单不能为空！'}
    end
  end

  def update
    material_purchase_detail = MaterialPurchaseDetail.find(params[:id])
    authorize material_purchase_detail
    flag, material_purchase_detail = MaterialPurchaseDetail::Update.(material_purchase_detail, permitted_attributes(material_purchase_detail))
    if flag
      render json: {status: 'ok', material_purchase: material_purchase_json(material_purchase_detail.material_purchase)}
    else
      render json: {status: 'failed', error_message: '出错了!'}
    end
  end

  private
  def material_purchase_json(material_purchases)
    material_purchases.as_json(
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




end
