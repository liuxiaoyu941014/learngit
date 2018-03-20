module Favorite
  module ActsAsFavoriteable
    extend ActiveSupport::Concern

    class_methods do
      def acts_as_favoriteable(resource:)
        include Favorite::EntriesControllerConcern
        helper Favorite::Helpers
        define_method :resource_of_favorites do
          resource
        end
      end
    end
  end
end