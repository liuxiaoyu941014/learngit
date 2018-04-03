require 'root_domain'
module FrontendRoute
  def self.extended(router)
    router.instance_exec do
      constraints(RootDomain) do
        root to: redirect('/', subdomain: 'www')
      end
      devise_for "users", skip: [:sessions, :passwords, :registrations], :controllers => { :omniauth_callbacks => 'users/omniauth_callbacks' }
      devise_scope :user do
        post '/sessions/:id/impersonate', to: 'users/sessions#impersonate', as: :impersonate_session
        post '/sessions/stop_impersonating', to: 'users/sessions#stop_impersonating', as: :stop_impersonating_sessions
        post 'sign_in', to: 'users/sessions#create'
        delete 'sign_out', to: 'users/sessions#destroy'
        post 'sign_up', to: 'users/registrations#create'
        get  'sign_up', to: 'users/registrations#new'
      end

      # 微信注册／登录
      namespace :users do
        namespace :weixins do
          resource :registrations, only: [:new, :show]
          resource :sessions, only: [:new] do
            collection do
              post 'status'
              get 'login'
            end
          end
          resource :connects, only: [:new, :create] do
            collection do
              post "status"
              get "confirm"
            end
          end
        end
      end

      if Rails.env.development?
        get '/test-room', to: 'test_room#index'
        post '/test-room', to: 'test_room#create'
        delete '/test-room/:id', to: 'test_room#destroy'
      end

      # 前端页面路由
      resource :users, except: [:create, :destroy, :new], controller: 'frontend/users' do
        get "self_order"
        get "self_comment"
        get "self_complaint"
        post "self_complaint"
        get "self_message"
        post "headshot"
        get "binding_phone"
        get "binding_weixin"
        post "binding_weixin"
        post "binding_phone"
      end


      
      
      # [ 商家, 产品, 新闻 ] 查询路由配置
      get :search_result, to: 'frontend/search#search_result'
      # 文广痛微场馆路由配置
      resources :micro_website, only: :index, controller: 'frontend/micro_website'
      resource :micro_website, only: [], controller: 'frontend/micro_website' do
        get 'wechat_sites' # 场馆列表
        get 'wechat_products' # 活动列表
        get 'wechat_news' # 新闻
        get 'wechat_login' #微信登录
        get 'wechat_orders' #订单列表(验票)
        get 'wechat_order' #订单详细(验票)
        post 'wechat_confirm_order'
        
        get 'wechat_product/:id', action: 'wechat_product', as: 'wechat_product'
        get 'wechat_site/:id', action: 'wechat_site', as: 'wechat_site'
        get 'wechat_new/:id', action: 'wechat_new', as: 'wechat_new'
      end

      namespace :frontend do 
       
        get 'courses/index'
        get 'classorders/showtable'
        resources :courses, :classorders  
        resources :smusers   
        get 'home/index'       
        match 'share/(:class/:id)', to: "share#index", via: :get
        resources :orders do
          collection do
            get "search"
            post "do_search"
            get "search_result"
            post "charge"
          end
          member do
            get :paid_success
            post "confirm" #确认消费
            post "refund"  #退款申请
          end
        end

        resources :communites
        resources :sites do
          commentable
        end
        resources :site_catalogs do
          resources :sites
        end
        resources :products do
          commentable
        end
        resources :product_catalogs do
          resources :products
        end
       
       
       

      end
    end
  end
end
