module Favorite
  module EntriesControllerConcern
    def show_favorite
      render json: favorite__resolve_resource.favorites.tagged_by?(favorite__user)
    end

    def create_favorite
      entry = favorite__resolve_resource.favorites.tag_by!(favorite__user)
      if entry.save
        render json: true
      else
        head 403
      end
    end

    def delete_favorite
      entry = favorite__resolve_resource.favorites.untag_by!(favorite__user)
      render json: false
    end

    private

    def favorite__user
      defined?(current_user) && current_user
    end

    def favorite__resolve_resource
      resource =
        case resource_of_favorites
        when Proc; instance_exec(&resource_of_favorites)
        when Symbol; __send__(resource_of_favorites)
        else
          resource_of_favorites.find(params[:id])
        end
    end
  end
end
