module AppAPI::V1
  class SiteCatalog < Grape::API
    helpers AppAPI::SharedParams
    resources :site_catalogs do

      desc '获取分类信息' do
        success AppAPI::Entities::SiteCatalog
      end
      params do
        requires :id, type: Integer, desc: '分类ID'
        use :pagination
        use :sort, fields: [:id, :created_at, :updated_at]
      end
      get ':id' do
        site_catalog = ::SiteCatalog.find(params[:id])
        present site_catalog, with: AppAPI::Entities::SiteCatalog
        wrap_collection site_catalog.sites, AppAPI::Entities::Site
      end

      desc '获取分类列表' do
        success AppAPI::Entities::SiteCatalog.collection
      end
      params do
        use :pagination
        use :sort, fields: [:id, :created_at, :updated_at]
        optional :type, type: String, values: ['flatform_recommend'], desc: "平台推荐"
        optional :name, type: String, desc: '分类名称模糊搜索'
      end
      get do
        site_catalogs = ::SiteCatalog.all
        if params[:name] || params[:type]
          # 查询分类
          site_catalogs = site_catalogs.where("name like ?", "%#{params[:name]}%") if params[:name]
          if params[:type]
            case params[:type]
            when 'flatform_recommend'
              site_catalogs = site_catalogs.where(is_hot: true)
            end
          end
          site_catalogs = paginate_collection(sort_collection(site_catalogs), params)
          wrap_collection site_catalogs, AppAPI::Entities::SiteCatalog
        else
          # 查看所有分类
          site_catalogs = ::SiteCatalog.where(parent_id: nil)
          site_catalogs = paginate_collection(sort_collection(site_catalogs), params)
          wrap_collection site_catalogs, AppAPI::Entities::SiteCatalog, includes: [:children]
        end
      end

    end # end of resources
  end
end
