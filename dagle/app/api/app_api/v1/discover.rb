module AppAPI::V1
  class Discover < Grape::API
    helpers AppAPI::SharedParams
    resources :discovers do

      desc '发现列表' do
        success AppAPI::Entities::Discover
      end
      params do
        use :pagination
        use :sort, fields: [:created_at]
      end
      get do
        discovers = paginate_collection(sort_collection(::Discover.all), params)
        wrap_collection discovers, AppAPI::Entities::Discover
      end
    end # end of resources
  end
end
