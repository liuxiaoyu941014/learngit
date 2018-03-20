class MarketTemplatePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes_for_create
    if user.has_role? :admin
      [:catalog_id, :name, :base_path, :keywords, :description, :image_path, :is_published, :html_source, :form_source]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
