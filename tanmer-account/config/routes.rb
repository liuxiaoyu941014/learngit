Rails.application.routes.draw do

  use_doorkeeper do
    controllers applications: 'apps'
  end

  devise_for :users, skip: [:sessions, :password, :registrations, :unlocks],
    controllers: { :omniauth_callbacks => "users/omniauth_callbacks" }

  get :login, to: 'sessions#new'
  post :login, to: 'sessions#create'
  if ENV['ENABLE_REGISTERATION'] == 'true'
    get :sign_up, to: 'registrations#new'
    post :sign_up, to: 'registrations#create'
  end
  get :logout, to: 'sessions#destroy'
  get 'sessions/status', to: 'sessions#status'
  get 'sessions/get-token', to: 'sessions#get_token'
  post 'sessions/sms-auth-code', to: 'sessions#sms_auth_code_for_login'
  post 'sessions/sms-auth', to: 'sessions#sms_auth_for_login'
  post 'registrations/sms-auth-code', to: 'registrations#sms_auth_code_for_register'
  post 'registrations/sms-auth', to: 'registrations#sms_auth_for_register'

  post 'login-with-token', to: 'sessions#create_with_token' # this route is a example for Application Client

  resources :users
  resources :roles
  resource :profile
  resources :tokens
  resource :system_settings, only: [:show]

  root to: 'home#index'
  get :healthz, to: 'home#healthz'
  get 'pages/agreement'
  get 'pages/privacy'

  namespace :api do
    namespace :v1 do
      resource :users, only: [] do
        get :profile
      end

      resources :permissions, except: [:new, :edit]
      scope :auth, controller: 'auth', as: :auth do
        # post :with_token
        # auth from "HTTP_AUTHORIZATION"=>"Basic bWVAemhhbmd4aC5uZXQ6bXlwYXNz"
        #   it includes username and api token
        get :http_digest
      end
    end
  end
end
