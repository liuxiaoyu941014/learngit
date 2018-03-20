module Tracker
  module ActsAsTrackable
    extend ActiveSupport::Concern

    def tracker_visit
      @_tracker_visit
    end

    def track_visit_wraper
      handler = Tracker::Handler.new(tracker_options, self)
      handler.pre_response
      yield
      handler.post_response
    end

    class_methods do
      def acts_as_trackable(options={})
        around_action :track_visit_wraper, options.except(:user, :resource, :payload)
        define_method :tracker_options do
          Options.new(options, self)
        end
      end
    end
  end
end
