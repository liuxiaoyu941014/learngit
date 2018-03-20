require "tracker/engine"
require 'tracker/options'
require 'tracker/handler'
require 'tracker/acts_as_trackable'
require 'tracker/has_many_visits'

module Tracker
  # Your code goes here...
  @@user_model_name = 'User'
  mattr_accessor :user_model_name
end
