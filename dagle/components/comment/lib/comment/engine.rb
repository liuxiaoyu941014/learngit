module Comment
  class Engine < ::Rails::Engine
    isolate_namespace Comment
    require 'cells'
    require 'cells-rails'
    require 'cells-slim'
    require 'kaminari'

    config.cells.with_assets = ["comment/base_cell", "tracker/base_cell"]

    require 'comment/helpers'
    require 'comment/routes'
    require "comment/acts_as_commentable"
    require "comment/has_many_comments"
    initializer "comment.initialize" do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send(:include, Comment::ActsAsCommentable)
      end
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, Comment::HasManyComments
      end
    end
  end
end
