# https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-(and-RSpec)
# https://github.com/plataformatec/devise/wiki/How-To:-Test-with-Capybara
module ControllerMacros
  extend ActiveSupport::Concern

  included do
    include Warden::Test::Helpers
  end

  class_methods do
    def login_admin
      login_user(:admin)
    end

    def login_agent
      login_user(:agent)
    end

    def login_user(user = :user)
      before(:each, type: :request) do
        login_as(FactoryGirl.create(user), :scope => :user)
      end
      before(:each, type: :controller) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        sign_in FactoryGirl.create(user)
      end
    end
  end
end
