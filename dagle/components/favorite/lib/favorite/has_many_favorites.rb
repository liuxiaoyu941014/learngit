module Favorite
  module HasManyFavorites
    extend ActiveSupport::Concern

    class_methods do
      def has_many_favorites
        has_many :favorites, class_name: 'Favorite::Entry', dependent: :destroy, as: :resource do
          def tag_by!(user)
            find_or_create_by(user: user)
          end
          def untag_by!(user)
            where(user: user).destroy_all
          end
          def tagged_by?(user)
            where(user: user).exists?
          end
        end
      end
    end
  end
end
