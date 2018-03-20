module Tracker
  class Action < ApplicationRecord
    has_many :visits
    validates_uniqueness_of :action_name, scope: :controller_path
    validates_presence_of :controller_path
    validates_presence_of :action_name

  end
end
