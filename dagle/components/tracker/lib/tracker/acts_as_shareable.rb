module Tracker
  module ActsAsTrackable
    extend ActiveSupport::Concern

    def tracker_visit
      @_tracker_visit
    end

    # TODO: check share_code and record user relation
    def track_share
      share_code = params[:tracker_share_code]
    end

    class_methods do
      def acts_as_shareable(options)
        before_action :track_share, options.except(:user, :resource, :payload)
        define_method :tracker_share_options do
          Options.new(options)
        end
      end
    end
  end
end
