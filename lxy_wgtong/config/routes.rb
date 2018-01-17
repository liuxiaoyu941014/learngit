Rails.application.routes.draw do
  get 'users/sign_up'
  get 'users/sign_in'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to =>"culture#index"
end
