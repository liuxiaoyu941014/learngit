require 'devise'
require_relative 'controller_macros'
RSpec.configure do |config|
  config.include Devise::Test::ControllerHelpers, :type => :controller
  config.include ControllerMacros, :type => :controller
  config.include ControllerMacros, :type => :request
end
