Rails.application.routes.draw do
  resources :posts do
    commentable
  end
end
