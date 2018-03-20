require 'rails_helper'

RSpec.describe "routing to frontend", :type => :routing do
  it { expect(get: '/').to route_to('home#index') }
  describe "Session" do
    it { expect(post: '/sessions/1/impersonate').to route_to('users/sessions#impersonate', id: "1") }
    it { expect(post: '/sessions/stop_impersonating').to route_to('users/sessions#stop_impersonating') }
    it { expect(post: '/sign_in').to route_to('users/sessions#create') }
    it { expect(delete: '/sign_out').to route_to('users/sessions#destroy') }
    it { expect(post: '/sign_up').to route_to('users/registrations#create') }
    it { expect(get: '/users/auth/wechat').to route_to('users/omniauth_callbacks#passthru') }
    it { expect(post: '/users/auth/wechat').to route_to('users/omniauth_callbacks#passthru') }
    it { expect(get: '/users/auth/wechat/callback').to route_to('users/omniauth_callbacks#wechat') }
    it { expect(post: '/users/auth/wechat/callback').to route_to('users/omniauth_callbacks#wechat') }
  end
end
