module AppAPI::V1
  class ProductCatalog < Grape::API
    helpers AppAPI::SharedParams
    resources :product_catalogs do

      desc '获取分类信息' do
        success AppAPI::Entities::ProductCatalog
      end
      params do
        requires :id, type: Integer, desc: '分类ID'
      end
      get ':id' do
        authenticate!
        present ::ProductCatalog.find(params[:id]), with: AppAPI::Entities::ProductCatalog, includes: [:products]
      end

      desc '获取分类列表' do
        success AppAPI::Entities::ProductCatalog.collection
      end
      params do
        use :pagination
        use :sort, fields: [:id, :created_at, :updated_at]
        # optional :type, type: String, values: ['hot', 'new', 'favorite'], desc: '分类排行：最热门产品，最新上架产品，最私藏产品'
      end
      get do
        authenticate!
        # 查看所有分类
        product_catalogs = ::ProductCatalog.all
        product_catalogs = paginate_collection(sort_collection(product_catalogs), params)
        wrap_collection product_catalogs, AppAPI::Entities::ProductCatalog
      end

    end # end of resources
  end
end
