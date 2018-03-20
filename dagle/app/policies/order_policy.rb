class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def create?
    user.super_admin_or_admin? || user.permission?(:create_order)
  end

  def update?
    user.super_admin_or_admin? || user.permission?([:order_material_split, :confirm_delivery]) || user.has_role?(:agent)
  end

  def update_code?
    user.super_admin_or_admin? && record.processing?
  end

  def refund?
    user.super_admin_or_admin? || user.permission?(:refund_order)
  end

  def apply_refund?
    user.super_admin_or_admin? || user.permission?(:refund_order)
  end

  def refund_success?
    user.super_admin_or_admin? || user.permission?(:refund_success)
  end

  def refunds?
    user.super_admin_or_admin? || user.permission?(:refund_order)
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin? || user.permission?(:create_order)
      [:user_id, :site_id, :code, :member_id, :preorder_conversition_id, :price, :description, :status, :internal_status, :delivery_date, :member_name, :mobile_phone, :refund_description, :apply_refund_by, :delivery_fee ,:image_item_ids => [], :attachment_ids => []]
    elsif user.has_role? :agent
      [:status, :internal_status, :price]
    else
      [:status, :internal_status]
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end

  def create_comment?
    create?
  end
end
