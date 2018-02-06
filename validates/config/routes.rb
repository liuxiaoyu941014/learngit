Rails.application.routes.draw do
  devise_for :users 
  root to: 'welcome#index'
  # post '/models/sign_in' => 'application/create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end