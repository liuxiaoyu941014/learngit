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

module Tmf
  class Application < Rails::Application
    require "settings"

    if Rails.env.development? && !Dir.exists?(Rails.root.join('public/templetes'))
      puts "第一次运行，正常克隆cms-templates项目到public/templetes"
      Dir.chdir Rails.root.to_s
      system "git clone git@gitlab.tanmer.com:tanmer/cms-templates.git public/templetes"
    end

    # We don't want include all helpers to controller
    #   CMS helpers to CMS controllers
    #   Admin helpers to Admin controllers
    config.action_controller.include_all_helpers = false
    config.autoload_paths << Rails.root.join('config/routes')

    generators do |app|

      require 'rails/generators/base'
      require 'generators/base_concern'
      Rails::Generators::Base.send :include, Generators::BaseConcern

      require 'rails/generators/rails/scaffold_controller/scaffold_controller_generator'
      require 'generators/modulize_template_concern'
      Rails::Generators::ScaffoldControllerGenerator.send :include, Generators::ModulizeTemplateConcern

      require 'rails/generators/rails/model/model_generator'
      Rails::Generators::ModelGenerator.hook_for :cud, default: true
      Rails::Generators::ModelGenerator.hook_for :audited, default: true, as: 'model'
      Rails::Generators::ModelGenerator.hook_for :pundit, default: true, as: 'policy', in: 'pundit'
    end
    config.generators do |g|
      # Themeable options
      g.theme_scaffold_mapping = {
        admin: { theme: 'color_admin', theme_scaffold: 'admin' },
        agent: { theme: 'color_admin', theme_scaffold: 'agent' }
      }
      g.test_framework :rspec
      g.scaffold_stylesheet false # don't generate app/assets/stylesheets/scaffolds.scss
    end

    I18n.config.enforce_available_locales = false

    config.i18n.available_locales = ["zh-CN"]
    config.i18n.default_locale = "zh-CN".to_sym
    config.before_configuration do
      I18n.locale = "zh-CN".to_sym
      I18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '**', '*.{rb,yml}')]
      I18n.reload!
    end

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options, :put, :update, :delete]
      end
    end
    # config.middleware.use Rack::RubyProf, :path => '/temp/profile'
    config.middleware.insert_after Warden::Manager, SalesDistribution::Middleware do |config|
      config.route_prefix = 'code-'
      config.current_user = ->(env) { env['warden'].user }
      config.user_class_name = 'User'
    end
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
