require 'rails_helper'

RSpec.describe "Routing to Agent,", :type => :routing do
  it { expect(get: '/agent').to route_to('agent/home#index') }
  it { expect(get: '/agent/sign_in').to route_to('agent/sessions#new') }
  describe 'Members' do
    it { expect(get: '/agent/members').to route_to 'agent/members#index' }
    it 'support pagination' do
      expect(get: '/agent/members/page-1').to route_to 'agent/members#index'
    end
    it { expect(post: '/agent/members').to route_to 'agent/members#new' }
    it { expect(get: '/agent/members/1').to route_to 'agent/members#show' }
    it { expect(put: '/agent/members/1').to route_to 'agent/members#edit' }
    it { expect(delete: '/agent/members/1').to route_to 'agent/members#destroy' }
  end

  describe 'Products' do
    it { expect(get: '/agent/products').to route_to 'agent/products#index' }
    it { expect(get: '/agent/products/1').to route_to 'agent/products#show' }
    it { expect(put: '/agent/products/1').to route_to 'agent/products#edit' }
    it { expect(delete: '/agent/products/1').to route_to 'agent/products#destroy' }
  end

  describe 'Orders' do
    it { expect(get: '/agent/orders').to route_to 'agent/orders#index' }
    it { expect(get: '/agent/orders/1').to route_to 'agent/orders#show' }
    it { expect(put: '/agent/orders/1').to route_to 'agent/orders#edit' }
    it { expect(delete: '/agent/orders/1').to route_to 'agent/orders#destroy' }
  end
end
