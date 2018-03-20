module Tracker
  class ShareCode < ApplicationRecord
    belongs_to :user, class_name: Tracker.user_model_name
    belongs_to :resource, polymorphic: true
  end
end
