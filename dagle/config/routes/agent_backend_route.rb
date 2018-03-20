module AgentBackendRoute
  def self.extended(router)
    router.instance_exec do
      namespace :agent do
        get '/', to: 'home#index', as: :root
        get 'sign_in', to: 'sessions#new'
        get 'assets/index'
        get 'assets/intranet_images'
        get 'assets/extranet_images'

        resources 'messages', only: [:index, :update]
        resources 'sites' do
          post :binding_wx_callback
          get :binding_wx_callback
        end
        resources 'products' do
          commentable
          member do
            post 'process_shelves'
            post 'sales_distribution'
            get 'download_signup_members'
            get 'orders'
          end
        end
        resources 'orders' do
          member do
            put :order_delivery
          end
        end
        resources 'statistics'

        resources 'members' do
          resources 'member_notes'
        end

        resources 'preorder_conversitions' do
          commentable
          member do
            post :site_confirm
          end
        end

        resources :deliveries, except: [:show]

        catalog_resources_for ProductCatalog, only: [:index]
        resources :market_pages, :concerns => :paginatable
        resources :agent_plans, only: [:index] do
          member do
            post :charge
            get :paid_success
          end
        end

        namespace :tracker do
          get '/', to: 'home#index'
          namespace :visits do
            resource :statistics, only: [:show]
            resource :details, only: [:show]
          end
          resources :shares, only: [:index] do
            collection do
              post "chart_data"
            end
            resources :two_shares, only: [:index] do
              resources :three_shares, only: [:index]
            end
          end
        end
        resources :finance_bills, only: [:index, :new, :create] do
          collection do
            get "fund"
          end
        end
        # 一键更新微信菜单
        resources :diymenus, except: :show do
          collection do
            post :sort
            post :upload_wx_menu
            post :download_wx_menu
          end
        end
        # resources :finances, only: [:index]
      end
    end
  end
end
