Rails.application.routes.draw do
  get 'home/index'

  mount Tracker::Engine => "/tracker"
end
