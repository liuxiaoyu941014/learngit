class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def recommend?
    create?
  end

  def permitted_attributes_for_create
    if user.has_role? :admin
      [:title, :description, :valid_time_begin, :valid_time_end, :tag_list, :article_type, :is_top, :recommend, :image_item_ids => []]
    else
      []
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
