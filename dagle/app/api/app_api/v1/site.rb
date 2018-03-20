module AppAPI::V1
  class Site < AppAPI::BaseAPI
    helpers AppAPI::SharedParams
    resources :sites do

      desc "获取定位小区附近#{::Site.model_name.human}列表" do
        success AppAPI::Entities::SiteSimple.collection
      end
      params do
        use :pagination
        optional :type, type: String, values: ['flatform_recommend'], desc: '平台推荐'
        if Settings.project.meikemei?
          requires :lat, type: String, desc: '所在位置纬度'
          requires :lng, type: String, desc: '所在位置经度'
        end
      end
      get 'near_by' do
        authenticate! unless Settings.project.meikemei?
        if Settings.project.imolin?
          error! '请先设置您的小区信息' unless current_user.current_community
          community = current_user.current_community
          sites = ::Site.where("features ->> 'is_published' = ?", "1").near_by(lat: community.address_lat, lng: community.address_lng, distance: 2000)
        elsif Settings.project.meikemei?
          sites = ::Site.near_by(lat: params[:lat], lng: params[:lng], distance: 20000)
        end
        case params[:type]
        when 'flatform_recommend'
          sites = sites.where(is_flatform_recommend: true)
        end
        sites = paginate_collection(sort_collection(sites), params)
        wrap_collection sites, AppAPI::Entities::SiteSimple, includes: [:distance], type: :full_site
      end

      desc "获取#{::Site.model_name.human}信息" do
        success AppAPI::Entities::Site
      end
      params do
        requires :id, type: Integer, desc: "#{::Site.model_name.human}ID"
      end
      get ':id' do
        authenticate! unless Settings.project.meikemei?
        if Settings.project.imolin?
          site = ::Site.find(params[:id])
          present site, with: AppAPI::Entities::Site, includes: [:products], type: :full_site, user_id: current_user.id
        else
          present ::Site.find(params[:id]), with: AppAPI::Entities::Site, includes: [:products], user_id: (current_user ? current_user.id : nil)
        end
      end

      desc "获取#{::Site.model_name.human}列表" do
        success AppAPI::Entities::SiteSimple.collection
      end
      params do
        use :pagination
        # use :sort, fields: [:id, :created_at, :updated_at]
        # optional :friends, type: Boolean, desc: "好友#{::Site.model_name.human}"
        optional :favorite, type: String, values: ['mine', 'friends', 'top3'], desc: "私藏#{::Site.model_name.human}：我的私藏#{::Site.model_name.human}，好友私藏的#{::Site.model_name.human}，被私藏数高的#{::Site.model_name.human}top3"
        optional :site_catalog_id, type: Integer, desc: "根据分类显示#{::Site.model_name.human}列表"
        optional :name, type: String, desc: "根据店铺名称模糊搜索"
      end
      get do
        authenticate! unless Settings.project.meikemei?
        sites = ::Site.where.not(id: ::Site::MAIN_ID)
        if params[:favorite]
          sites =
            case params[:favorite]
            when 'mine'    then sites.joins(:favorites).where(favorite_entries: {user_id: current_user.id})
            when 'friends' then sites.joins(:favorites).where(favorite_entries: {user_id: current_user.friends})
            when 'top3'    then sites.joins(:favorites).group("sites.id").order('COUNT(favorite_entries.id) DESC').limit(3)
            end
        end
        if params[:friends]
          # 获取好友店铺
          sites = ::Site.where(user_id: current_user.friends)
        end

        # 模糊查询获取店铺
        if params[:name]
          sites = sites.where("title like ?", "%#{params[:name]}%")
        end
        if Settings.project.imolin?
          community = current_user.current_community
          error! "用户还没有选择小区" unless community
          # 获取发布的店铺
          sites = sites.published

          if params[:site_catalog_id]
            sites = sites.where("catalog_id = ?", params[:site_catalog_id])
            sites = sites.near_by(lat: community.address_lat, lng: community.address_lng, distance: 2000)
          else
            # 所有店铺都要获取distance（小区距离）信息
            sites = sites.selecting_distance_from(community.address_lat, community.address_lng).order_by_distance(community.address_lat, community.address_lng)
          end
        end
        sites = paginate_collection(sort_collection(sites), params)
        if Settings.project.imolin?
          wrap_collection sites, AppAPI::Entities::SiteSimple, includes: [:distance], type: :full_site
        else
          wrap_collection sites, AppAPI::Entities::SiteSimple, type: :full_site
        end
      end

      desc '店铺站长推荐'
      params do
        requires :id, type: Integer, desc: "#{::Site.model_name.human}ID"
      end
      get ':id/manager_recommend' do
        authenticate!
        site = ::Site.find_by(id: params[:id])
        error! '店铺不存在' unless site
        recommend_products = site.products.where("features ->> 'is_manager_recommend' = '1'").where("features ->> 'is_shelves' = '1'").limit(5)
        present recommend_products, with: AppAPI::Entities::SiteRecommend
      end

      desc '收藏店铺'
      params do
        requires :id, type: Integer, desc: "#{::Site.model_name.human}ID"
      end
      post ':id/favorite' do
        authenticate!
        site = ::Site.find(params[:id])
        message = ''
        if current_user.favorites.tagged_to? site
          message = '已经收藏了此店铺!'
        else
          current_user.favorites.tag_to! site
          message = '店铺收藏成功!'
        end
        present message: message
      end

      desc '取消收藏店铺'
      params do
        requires :id, type: Integer, desc: "#{::Site.model_name.human}ID"
      end
      delete ':id/favorite' do
        authenticate!
        site = ::Site.find(params[:id])
        if current_user.favorites.tagged_to? site
          current_user.favorites.untag_to! site
        end
        present message: '店铺取消收藏成功!'
      end

      desc '是否收藏了此店铺'
      params do
        requires :id, type: Integer, desc: "#{::Site.model_name.human}ID"
      end
      get ':id/is_favorited' do
        authenticate!
        site = ::Site.find(params[:id])
        is_favorited = if current_user.favorites.tagged_to? site
          true
        else
          false
        end
        present is_favorited: is_favorited
      end

      desc '评论店铺' do
        success AppAPI::Entities::Comment
      end
      params do
        requires :id, type: Integer, desc: '店铺ID'
        requires :content, type: String, desc: '评论或者回复内容'
        optional :parent_id, type: Integer, desc: '如果填写，parent_id就是回复的某条评论的ID'
      end
      post':id/comment' do
        authenticate!
        site = ::Site.find_by(id: params[:id])
        error! '该店铺不存在' unless site

        comment_attributes = {}
        comment_attributes[:content]  = params[:content]
        comment_attributes[:parent]   = ::Comment::Entry.where(id: params[:parent_id]).first unless params[:parent_id].blank?
        comment_attributes[:user]     = current_user

        comment = site.comments.new(comment_attributes)
        if comment.save
          present comment, with: AppAPI::Entities::Comment
        else
          error! comment.errors
        end
      end

      # imolin的特殊需求
      desc '店铺所有订单的评论' do
        success AppAPI::Entities::Comment.collection
      end
      params do
        requires :id, type: Integer, desc: '店铺ID'
        use :pagination
        use :sort, fields: [:created_at]
      end
      get ':id/order_comments' do
        site = ::Site.find_by(id: params[:id])
        error! '该店铺不存在' unless site
        comments = site.order_comments.displayable
        comments = paginate_collection(sort_collection(comments), params)
        wrap_collection(comments, AppAPI::Entities::Comment)
      end

    end # end of resources
  end
end
