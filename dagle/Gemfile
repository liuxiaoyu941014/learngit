source "https://gems.ruby-china.org"
ruby '2.3.3'

# set api key with
#   bundle config gems.tanmer.com your_api_key
# or
#   export BUNDLE_GEMS__TANMER__COM="your_api_key"
#
source "https://gems.tanmer.com" do
  gem 'payment_core', '0.0.4'
  gem 'theme_color_admin', '0.0.5'
  gem 'sales_distribution', '0.1.0'
  gem 'gnomon', '0.2.1'
  # comment this since it's merged
  # gem 'activerecord-postgres-earthdistance', '0.5.2.tanmer'
end

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.0', '>= 5.0.0.1'
# Use mysql as the database for Active Record
#gem 'mysql2', '>= 0.3.18', '< 0.5'
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# group :development, :test do
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .coffee assets and views
  gem 'coffee-rails', '~> 4.2'
  # See https://github.com/rails/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby
# end
gem 'tzinfo-data', '~> 1.2017', '>= 1.2017.2'

gem 'bootstrap-sass', '~> 3.3', '>= 3.3.7'
gem 'kaminari', '>= 1.0.1', '~> 1.0'
gem 'kaminari-i18n', '~> 0.4.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'high_voltage', '~> 3.0.0'
gem "rolify", '~> 5.1.0'
gem "pundit", '~> 1.1.0'
gem 'faraday', '~> 0.11.0'
# slim-rails 3.1.2 ckeditor会出错
#   https://github.com/slim-template/slim-rails/issues/140
#   https://github.com/galetahub/ckeditor/issues/734
gem 'slim-rails', '3.1.1'
gem 'devise', '~> 4.2.0'
gem 'devise-i18n'
gem 'jwt', '~> 1.5.6'
gem 'settingslogic', '~> 2.0.9'
gem 'figaro', '~> 1.1', '>= 1.1.1'
# gem 'swagger-docs' # 太麻烦，不如自己写markdown文档
gem 'font-awesome-rails', '~> 4.7.0'
gem 'simple_form', '~> 3.3.1'
gem 'active_model_serializers' # 不好用，不如直接as_json输出
gem 'like', path: 'components/like'

# gem 'active_model_serializers' # 不好用，不如直接as_json输出
#
# url-分销
# gem 'sales_distribution', git: 'git@gitlab.tanmer.com:tm-framework/sales_distribution.git'
# gem 'spreadsheet'
gem "roo"
gem 'roo-xls'

# gem 'client_side_validations',
#   github: 'DavyJonesLocker/client_side_validations',
#   branch: 'rails5'
# gem 'client_side_validations-simple_form',
#   github: 'DavyJonesLocker/client_side_validations-simple_form',
#   branch: 'rails5'

gem 'pretender' # 模仿另一个用户登录

gem 'ckeditor', '~> 4.2.2'
# 解决ckeditor资源无法加载的问题
gem 'non-stupid-digest-assets', '~> 1.0', '>= 1.0.9'


gem 'acts-as-taggable-on', '~> 4.0'

#File upload
gem 'paperclip'
# gem 'qiniu'
# gem 'paperclip-qiniu', '>= 0.2.0'

# In Rails 5, active_model/serializers/xml has been extracted into its own gem.
#   So, a quick solution is to add the activemodel-serializers-xml gem to your Gemfile
#   https://github.com/drapergem/draper/issues/697
# draper 和 Rails5 存在兼容性问题，不再使用
# gem 'draper', '~> 2.1.0'
# gem 'activemodel-serializers-xml', git: 'https://github.com/rails/activemodel-serializers-xml'

# Audited (previously acts_as_audited) is an ORM extension that logs all changes
#   to your models. Audited can also record who made those changes, save comments
#   and associate models related to the changes.
gem "audited", "~> 4.3"
gem "rails-observers", github: 'rails/rails-observers'
gem 'impressionist'

gem 'rails-i18n', '~> 5.0.0'
gem 'rails-i18n-generator'

gem 'chinese_pinyin'
#used in CMS: public/templetes/generate_templetes.rb
gem 'iconv', '~> 1.0', '>= 1.0.4'

#weixin
gem "weixin_rails_middleware", '~> 1.3', '>= 1.3.1'
gem 'weixin_authorize', '1.6.3'
gem "omniauth-wechat-oauth2", "~> 0.1.0"
gem 'rqrcode', '~> 0.10.1'

# require components
gem 'sms', path: 'components/sms'
gem 'tracker', path: 'components/tracker'
gem 'decorator', path: 'components/decorator'
gem 'comment', path: 'components/comment'
gem 'favorite', path: 'components/favorite'

gem 'themeable', '~> 1.2.0'#, path: '../../gems/themeable'
# gem 'theme_color_admin', git: 'git@gitlab.tanmer.com:tm-themes/theme_color_admin.git'
# gem 'theme_card', git: 'git@gitlab.tanmer.com:tm-themes/theme_card.git'
gem 'closure_tree'
gem 'select2-rails'
gem 'sidekiq'
gem 'sidekiq-cron', '~> 0.6.3'
gem 'redis-namespace'

# Markdown markup for doc
gem 'redcarpet', '~> 3.4.0'
gem 'github-markup'

# Grape API
# gem 'api', path: 'api'
gem 'grape', '~> 0.19.1'
gem 'grape-route-helpers', '~> 2.0'
gem 'grape-entity', '~> 0.6.1'
gem 'grape-swagger'
gem 'grape-swagger-entity', '~> 0.2.0'
gem 'grape-swagger-rails'#, group: [:development]
gem 'rack-cors', '~> 0.4.1'

# 调试性能，调试完后需要去掉
# gem 'ruby-prof'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'pry-rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'bower-rails'
  gem 'webmock'
  gem 'rails-controller-testing'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'guard-rails'
  gem 'guard-livereload'
  gem "rails-erd"
end

group :development, :doc do
  # https://github.com/lsegal/yard
  gem 'yard'
  # https://github.com/ctran/annotate_models
  gem 'annotate'
  gem 'simplecov'
end

group :deployment do
  gem 'capistrano', '~> 3.7.1'
  gem 'capistrano-rvm'
  gem 'capistrano-passenger'
  gem 'capistrano-rails'
  gem 'capistrano-sidekiq'
end

gem 'colorize', group: [:development, :test, :deployment]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'activemodel-serializers-xml'
gem 'vuejs-webpack-rails'

gem 'foreman'
gem 'newrelic_rpm'
