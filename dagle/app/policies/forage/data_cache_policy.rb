class Forage::DataCachePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin?
      [:title, :url, :processed_by, :auto_merge, :is_merged,
       :migrate_to, :catalog_id, :matched_status, :matched_ids, :matched_id, :can_purchase, :external_purchase_url,
       :keywords, :image, :description, :content, :date, :time, :address_line1, :address_line2, :phone, :price, :from, :site_name, :note]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
