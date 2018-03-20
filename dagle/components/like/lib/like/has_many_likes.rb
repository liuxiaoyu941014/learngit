module Like
  module HasManyLikes
    extend ActiveSupport::Concern

    class_methods do
      def has_many_likes
        has_many :likes, class_name: 'Like::Base', dependent: :destroy, as: :resource do
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
