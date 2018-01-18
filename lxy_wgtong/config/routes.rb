Rails.application.routes.draw do
  # get 'users/sign_up'
  # post "users/login_up"
   get 'users/login'
  resources :users
  post "sign_in" => "users#sign_in"
  get "login" => "users#login", :as => "login"
  delete "logout" => "users#logout", :as => "logout"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to =>"culture#index"
end
