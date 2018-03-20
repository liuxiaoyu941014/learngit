module Tracker
  module HasManyVisits
    extend ActiveSupport::Concern

    class_methods do
      def has_many_visits
        has_many :visits, class_name: 'Tracker::Visit', dependent: :destroy, as: :resource
      end
    end
  end
end
