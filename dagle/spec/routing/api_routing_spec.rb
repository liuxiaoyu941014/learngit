require 'rails_helper'

RSpec.describe "API", :type => :routing do
  it { expect(get: '/api').to route_to('api/home#index') }
  describe "V1" do
    describe 'sessions' do
      it { expect(post: '/api/v1/sessions/sms').to route_to('api/v1/sessions/sms#create') }
    end
  end
end
