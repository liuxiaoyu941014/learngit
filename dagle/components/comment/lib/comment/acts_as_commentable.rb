module Comment
  module ActsAsCommentable
    extend ActiveSupport::Concern

    class_methods do
      def acts_as_commentable(resource:)
        include Comment::EntriesControllerConcern
        helper Comment::Helpers
        define_method :resource_of_comments do
          resource
        end
      end
    end
  end
end
