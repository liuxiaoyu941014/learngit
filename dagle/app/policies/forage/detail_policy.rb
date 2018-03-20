class Forage::DetailPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes_for_create
    # fail "请在#{__FILE__}中添加params的permit属性"
    if user.has_role? :admin
      [:simple_id, :url, :migrate_to, :can_purchase, :purchase_url, :title,
      :keywords, :image, :description, :content, :date, :time, :address_line1, :address_line2,
      :phone, :price, :from, :has_site, :site_name, :note, :features]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
