# 账户授权中心(SSO单点登录)

https://account.tanmer.com

本中心负责所有服务的用户登录，注册，获取权限的任务

## 使用的授权中心的服务

1. Tanmer Gem: https://gems.tanmer.com
2. Wxopen: https://wxopen.tanmer.com
4. 其他小项目...

## 如何部署

部署前，请检查`config/application.yml`的配置  
启动docker，然后执行`./build_docker.sh`，将会自动编译docker镜像

## 通过本服务进行oauth2授权登录

1. 在 https://account.tanmer.com/oauth/applications 中，添加一个应用
2. 在自己的网站中，通过 gem omniauth-tanmer ，配置好 app_id 和 app_secret 即可

  在`Gemfile`中添加`gem 'omniauth-tanmer', '~> 1.0', '>= 1.0.5'`
  配置环境变量：

    OAUTH_TANMER_KEY: bbb2f6eb6259
    OAUTH_TANMER_SECRET: eec6c6616fb01d8a7bc1044a
    OAUTH_TANMER_SITE: https://account.tanmer.com

  在`config/application.rb`中添加

    config.middleware.use OmniAuth::Builder do
        provider :tanmer, ENV['OAUTH_TANMER_KEY'], ENV['OAUTH_TANMER_SECRET'], client_options: { site: ENV['OAUTH_TANMER_SITE'] }
    end

## 通过本服务进行SSO单点授权登录

SSO单点授权登录, 需要目标网站和本服务在同一个主域名下，如：sso.tanmer.com 和 wxopen.tanmer.com。
方法同上，只是在添加应用时，把“单点登录”打钩，然后在自己的网站里，把退出登录链接改为https://account.tanmer.com/logout

## 其他网站调用登录组件(这个场景用的少，我们主要都是通过oauth2登录，或者单点的登录，因此我已经把源代码删除了，需要找回，请查询2018-02-24日的更新)

任何网站，都可以使调用用本授权中心登录界面，验证用户登录。适用方法如下：

在account.tanmer.com上申请一个Application，获的appid和app_secret，然后在www.example.com/login页面，添加如下代码：

    <div id="login-box" data-appid="a-appid-from-account-tanmer-com" data-login-url="http://www.example.com/login-with-token"></div>
    <%= javascript_include_tag "http://account.tanmer.com/packs/login-xxxx.js" %>
    <%= stylesheet_link_tag "http://account.tanmer.com/packs/login-xxxx.css" %>

login-xxxx具体是什么，访问`https://account.tanmer.com/packs/manifest.json`,
get mappings of login.css and login.js

https://account.tanmer.com/packs/login-aef96a3c4da19c465e3b804da9db5433.css

在http://www.example.com/login-with-token对应的action中，获取token并实现自己网站的登录：

    require 'des_encryptor'
    class SessionsController < ApplicationController
        skip_before_action :verify_authenticity_token
        def create
            token = params[:token].presence
            if token
            begin
                data, _ = JWT.decode(token, Rails.application.secrets.app_secret, 'HS256')
                user_info = data['info'].slice('name', 'image', 'gender')
                uid = DesEncryptor.decrypt(Rails.application.secrets.app_secret, data['uid'])
                Rails.logger.debug "login with token: #{uid} - #{user_info}"
                user = User.create_with(user_info).find_or_create_by(uid: uid)
                sign_in user
                render json: { success: true }
            rescue => ex
                render json: { error: ex.message }
            end
            else
            head 404
            end
        end

        def destroy
            sign_out_and_redirect :user
        end
    end

注意，`des_encryptor`需要把本项目的`lib/des_encryptor.rb`拷贝到自己的项目中。

## API 身份验证方式

1. HTTP Digest: `/api/v1/auth/http_digest`

    格式如下：
    => Authorization: Basic `Base64.decode64("username:api_auth_token")`
    => Authorization: Basic `Base64.decode64("email:api_auth_token")`
    => Authorization: Basic `Base64.decode64("mobile:api_auth_token")`

2. Token 验证：`/api/v1/users/profile`

    Header => Authorization: Bearer `token`

## 客户端怎么验证身份

我们客户端用 `warden`做用户登录，cookie保存。具体需要写的文件如下：

`app/models/user.rb`:

```ruby
class User
  include ActiveModel::Model
  attr_accessor :uid, :name, :email, :headshot, :token, :token_expires_at, :permissions

  def persisted?
    self.uid.present?
  end

  def self.find_by_token(token)
    tanmer = OmniAuth::Strategies::Tanmer.new(ENV['OAUTH2_TANMER_APPID'], ENV['OAUTH2_TANMER_APPSECRET'], client_options: { site: ENV['OAUTH2_TANMER_SITE'] })
    tanmer.access_token = ::OAuth2::AccessToken.new(tanmer.client, token)
    self.from_auth(tanmer.auth_hash)
  rescue OAuth2::Error
    nil
  end

  def self.from_auth(auth)
    new(
      uid: auth.uid,
      name: auth.info.name,
      email: auth.info.email,
      headshot: auth.info.image,
      token: auth.credentials.token,
      token_expires_at: auth.credentials.expires_at,
      permissions: auth.extra.raw_info['permissions']
    )
  end
end
```

`config/application.yml`:

```yaml
OAUTH2_TANMER_APPID: 62653a7cd76de279c5f5abe41e21db1d3b26c941125715b5342a54649707405f
OAUTH2_TANMER_APPSECRET: cdad0737136ff68a8183821cc357621571df4375308ba245c525afd36325bda9
OAUTH2_TANMER_SITE: https://account.tanmer.com
```

`config/application.rb`:

```ruby
config.middleware.use Warden::Manager do |manager|
    manager.default_strategies :oauth
    manager.failure_app = ErrorsController.action(:auth_failed)
end

config.middleware.use OmniAuth::Builder do
    OmniAuth.config.logger = Rails.logger
    provider :tanmer, ENV['TANMER_ACCOUNT_API_KEY'], ENV['TANMER_ACCOUNT_API_SECRET'], client_options: { site: ENV['TANMER_ACCOUNT_API_SITE'] }
end
```

`config/initializers/warden.rb`:

```ruby
Warden::Strategies.add(:oauth) do
  def authenticate!
    user && user.persisted?
  end
end

Warden::Manager.serialize_into_session do |user|
  user.token
end

Warden::Manager.serialize_from_session do |token|
  User.find_by_token(token)
end
```

`config/routes.rb`:

```ruby
get '/auth/tanmer/callback', to: 'auth#tanmer_callback'
delete :sign_out, to: 'sessions#destroy'
get :sign_in, to: redirect('/auth/tanmer')
```

`app/controllers/application_controller.rb`:

```ruby
class ApplicationController < ActionController::Base
  helper_method :current_user, :user_signed_in?

  def authenticate!
    warden.authenticate!
  end

  def current_user
    warden.user
  end

  def warden
    request.env['warden']
  end

  def user_signed_in?
    !!current_user
  end

  def sign_in_user(user)
    warden.set_user user
  end

  def sign_out_user
    warden.logout
  end
end
```

`app/controllers/auth_controller.rb`:

```ruby
class AuthController < ApplicationController
  def tanmer_callback
    user = User.from_auth(request.env['omniauth.auth'])
    sign_in_user(user)
    redirect_to request.env['omniauth.origin'] || root_path
  end
end
```

`app/controllers/sessions_controller.rb`
```ruby
class SessionsController < ApplicationController
  def destroy
    sign_out_user
    redirect_to request.referer || root_url
  end
end

```
