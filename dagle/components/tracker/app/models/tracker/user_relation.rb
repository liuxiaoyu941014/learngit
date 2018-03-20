module Tracker
  class UserRelation < ApplicationRecord
    belongs_to :master, class_name: Tracker.user_model_name
    belongs_to :slave, class_name: Tracker.user_model_name
  end
end
