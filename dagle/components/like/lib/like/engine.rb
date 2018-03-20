module Like
  class Engine < ::Rails::Engine
    isolate_namespace Like
    require 'like/has_many_likes'
    initializer "like.initialize" do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, Like::HasManyLikes
      end
    end

    config.after_initialize do
      Like.user_model_class.constantize.has_many :likes, class_name: 'Like::Base', foreign_key: :user_id, dependent: :destroy do
        def tag_to!(resource)
          find_or_create_by(resource: resource)
        end
        def untag_to!(resource)
          where(resource: resource).destroy_all
        end
        def tagged_to?(resource)
          where(resource: resource).exists?
        end
      end
    end

  end
end
