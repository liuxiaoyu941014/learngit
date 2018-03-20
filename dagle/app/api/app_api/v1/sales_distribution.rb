module AppAPI::V1
  class SalesDistribution < Grape::API
    helpers AppAPI::SharedParams
    resources :sales_distributions do

      desc '通过分销码获取用户信息'
      params do
        requires :code, type: String, desc: '分销码'
      end
      get do
        sales_distribution = ::SalesDistribution::Resource.find_by(code: params[:code])
        present sales_distribution, with: AppAPI::Entities::SalesDistribution
      end

    end # end of resources
  end
end
