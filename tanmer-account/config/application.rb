require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
require "sprockets/railtie"
# require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TanmerAccount
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    config.i18n.available_locales = ['zh-CN', :en]
    config.i18n.default_locale = 'zh-CN'
    config.time_zone = 'Beijing'
    config.middleware.insert_before 0, Rack::Cors, debug: true, logger: Rails.logger do
      allow do
        origins do |source, env|
          # appid = nil
          # if env['REQUEST_METHOD'] == 'OPTIONS'
          #   (env['HTTP_ACCESS_CONTROL_REQUEST_HEADERS'] || '').split(',').find { |k| k =~ /^x-appid-(.*)/ && appid = $1 }
          # else
          #   appid = env['HTTP_X_LOGIN_APPID']
          # end
          # appid && ApplicationSource.allow_cors?(appid.downcase, source)
          true # 临时允许所有域名跨域
        end
        # resource '*', headers: :any, :methods => :any, credentials: true
        resource '*', headers: :any, methods: :any, credentials: true, max_age: 600
      end
    end
    
    config.generators do |g|
      g.scaffold_stylesheet false
      g.helper false
      g.assets false
      g.test_framework false
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
