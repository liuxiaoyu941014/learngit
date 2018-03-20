module AppAPI::V1
  class Banner < Grape::API
    helpers AppAPI::SharedParams
    resources :banners do

      desc '轮波图'
      params do
        optional :diaplay_type, type: String, values: ['main', 'privated', 'discover'], desc: '轮波图：首页轮波图，私藏界面轮波图， 发现界面轮波图'
      end
      get do
        banners = if params[:diaplay_type] == 'privated'
          ::Banner.privated.sample(3)
        elsif params[:diaplay_type] == 'discover'
          ::Banner.discover.sample(3)
        elsif params[:diaplay_type] == 'main'
          ::Banner.main.sample(3)
        end

        present banners, with: AppAPI::Entities::Banner
      end

    end # end of resources
  end
end
