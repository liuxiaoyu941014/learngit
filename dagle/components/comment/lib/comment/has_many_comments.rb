module Comment
  module HasManyComments
    extend ActiveSupport::Concern

    class_methods do
      def has_many_comments
        has_many :comments, class_name: 'Comment::Entry', dependent: :destroy, as: :resource
      end
    end
  end
end
