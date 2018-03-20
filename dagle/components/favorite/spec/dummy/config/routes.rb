Rails.application.routes.draw do
  resources :products, only: [:show] do
    favoriteable
  end
  # mount Favorite::Engine => "/favorite"
end
