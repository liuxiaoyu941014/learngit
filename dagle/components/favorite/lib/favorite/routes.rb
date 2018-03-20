module ActionDispatch::Routing
  class Mapper
    def favoriteable
      member do
        get :favorite, action: :show_favorite, format: :json
        post :favorite, action: :create_favorite, format: :json
        delete :favorite, action: :delete_favorite, format: :json
      end
    end
  end
end