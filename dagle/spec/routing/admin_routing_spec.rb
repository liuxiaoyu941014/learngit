require 'rails_helper'

RSpec.describe "Routing to Admin,", :type => :routing do
  it { expect(get: '/admin').to route_to('admin/home#index') }
  it { expect(get: '/admin/sign_in').to route_to('admin/sessions#new') }

  describe 'Roles' do
    it { expect(get: '/admin/roles').to route_to 'admin/roles#index' }
    it 'support pagination' do
      expect(get: '/admin/roles/page-1').to route_to('admin/roles#index', page: '1')
    end

    it '显示角色下的所有用户' do
      expect(get: '/admin/roles/1/users').to route_to('admin/users#index', role_id: '1')
    end
    it { expect(get: '/admin/roles/1/users/page-1').to route_to('admin/users#index', role_id: '1', page: '1') }
  end

  describe 'Users' do
    it { expect(get: '/admin/users').to route_to 'admin/users#index' }
    it 'support pagination' do
      expect(get: '/admin/users/page-1').to route_to('admin/users#index', page: '1')
    end
    it { expect(get: '/admin/users/new').to route_to 'admin/users#new' }
    it { expect(get: '/admin/users/1').to route_to('admin/users#show', id: '1') }
    it { expect(get: '/admin/users/1/edit').to route_to('admin/users#edit', id: '1') }
    it { expect(delete: '/admin/users/1').to route_to('admin/users#destroy', id: '1') }
  end

  describe 'Tracker' do
    it { expect(get: '/admin/tracker').to route_to 'admin/tracker/home#index' }
    it { expect(get: '/admin/tracker/visits/statistics').to route_to 'admin/tracker/statistics#show' }
    it { expect(get: '/admin/tracker/visits/details').to route_to 'admin/tracker/visits/details#show' }
    describe 'Shares' do
      it { expect(get: '/admin/tracker/shares').to route_to 'admin/tracker/shares#index' }
      it 'support pagination' do
        expect(get: '/admin/tracker/visits/shares/page-1').to route_to 'admin/tracker/shares#index'
      end
    end
  end
end
