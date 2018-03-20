module AppAPI::V1
  class Staff < Grape::API
    helpers AppAPI::SharedParams
    resources :staffs do

      desc '获取美容师信息' do
        success AppAPI::Entities::Staff
      end
      params do
        requires :id, type: Integer, desc: '美容师ID'
      end
      get ':id' do
        authenticate! unless Settings.project.meikemei?
        present ::Staff.find(params[:id]), with: AppAPI::Entities::Staff #, includes: [:products]
        # AppAPI::Entities::Staff.represent(::Staff.find(params[:id]), only: [:title])
      end

      desc '获取美容师列表' do
        success AppAPI::Entities::Staff.collection
      end
      params do
        use :pagination
        # use :sort, fields: [:id, :created_at, :updated_at]
        # optional :friends, type: Boolean, desc: '好友美容师'
        optional :favorite, type: String, values: ['private', 'friends', 'all'], desc: '私藏美容师：我的私藏美容师，好友私藏的美容师，被私藏数高的美容师'
      end
      get do
        authenticate! unless Settings.project.meikemei?
        staffs = ::Staff.all
        if params[:favorite]
          staffs =
            case params[:favorite]
            when 'private' then staffs.where(id: current_user.favorites.where(resource_type: 'Staff').map(&:resource_id))
            when 'friends' then staffs.where(user_id: current_user.favorites.where(resource_type: 'User').map(&:resource_id))
            when 'all'     then staffs.left_joins(:favorites).group("staffs.id").order('COUNT(favorite_entries.id) DESC')
            end
        end
        staffs = paginate_collection(sort_collection(staffs), params)
        wrap_collection staffs, AppAPI::Entities::Staff
      end

    end # end of resources
  end
end
