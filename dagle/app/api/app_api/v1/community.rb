module AppAPI::V1
  class Community < AppAPI::BaseAPI
    helpers AppAPI::SharedParams
    resources :communities do
      desc '小区列表' do
        success success AppAPI::Entities::Common
      end
      params do
        use :pagination
        use :sort, fields: [:distance, :name]
        optional :longitude, type: Float, desc: '经度'
        optional :latitude, type: Float, desc: '纬度'
        optional :distance, type: Integer, desc: '范围（米）', default: 500, values: 0..50_000
        all_or_none_of :longitude, :latitude, :distance
      end
      get do
        communities = ::Community.published
        if params[:latitude] && params[:longitude]
          communities = communities.near_by(lat: params[:latitude], lng: params[:longitude], distance: 500)
        else
          params[:_sort] = nil if params[:_sort] == 'distance'
        end
        communities = paginate_collection(sort_collection(communities), params)
        wrap_collection communities, AppAPI::Entities::CommunitySimple
      end

    end
  end
end
