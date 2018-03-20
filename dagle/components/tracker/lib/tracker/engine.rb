module Tracker
  class Engine < ::Rails::Engine
    isolate_namespace Tracker
    require 'cells'
    require 'cells-rails'
    require 'cells-slim'
    require 'browser'
    config.cells.with_assets = ["tracker/base_cell"]
    initializer "tracker.initialize" do
      ActiveSupport.on_load(:action_controller) do
        ActionController::Base.send(:include, Tracker::ActsAsTrackable)
      end
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :include, Tracker::HasManyVisits
      end
    end
  end
end
