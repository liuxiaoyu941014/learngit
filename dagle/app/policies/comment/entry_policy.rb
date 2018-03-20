class Comment::EntryPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def permitted_attributes_for_create
    if user.super_admin_or_admin?
      [:content, :is_published]
    else
      [:content, :is_published]
    end
  end

  def permitted_attributes_for_update
    permitted_attributes_for_create
  end
end
