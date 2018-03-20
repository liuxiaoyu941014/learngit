class AddressBookPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin? || scope.where(:user_id => record.user_id)
      [:user_id, :name, :gender, :mobile_phone, :city, :street, :house_number, :note]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
