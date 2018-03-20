module AppAPI::V1
  class AppSettings < AppAPI::BaseAPI
    helpers AppAPI::SharedParams
    resources :app_settings do

      desc 'App配置信息'
      get do
        current_setting = AppSetting.current
        app_data = {
          article_share_url_pattern: current_setting.article_share_url_pattern,
          site_share_url_pattern: current_setting.site_share_url_pattern,
          product_share_url_pattern: current_setting.product_share_url_pattern,
          system_rooms: begin YAML.load(current_setting.system_rooms) rescue [] end,
          service_banners: begin YAML.load(current_setting.service_banners) rescue [] end,
          main_banners: begin YAML.load(current_setting.main_banners) rescue [] end,
          app_version_message: begin YAML.load(current_setting.app_version_message) rescue {} end
        }
        present app_data
      end

    end # end of resources
  end
end
