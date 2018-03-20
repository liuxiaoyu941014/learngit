module AppAPI::V1
  class User < AppAPI::BaseAPI
    helpers AppAPI::SharedParams
    resources :users do
      desc 'Ping status'
      get :ping do
        Time.now
      end

      desc '用户注册' do
        detail <<-DOC
目前只能够手机号+验证码注册
        DOC
        success AppAPI::Entities::User
      end
      params do
        requires :mobile_phone, type: String, desc: '手机号'
        requires :mobile_phone_code, type: String, desc: '手机验证码'
        optional :shared_code, type: String, desc: '邀请码, 注册时输入下面中任一邀请码就能和相应的店铺成为好友（"j1etq2qc", "j1ezcpy5", "j1ezhry5"）'
        optional :nickname, type: String, desc: '用户昵称'
        optional :device, type: String, desc: '设备信息，可以是UserAgent，也可以是自定义的名字。目的是让一个设备只生成一个access token'
      end
      post do
        t = Sms::Token.new(params[:mobile_phone])
        error! '验证码不正确！' unless t.valid?(params[:mobile_phone_code])

        user_attributes = {}
        user_attributes[:mobile_phone] = params[:mobile_phone]
        user_attributes[:nickname] = params[:nickname] if params[:nickname]
        if params[:shared_code]
          sale_resource = ::SalesDistribution::Resource.where(code: params[:shared_code]).first
        end
        flag, user = ::User::Create.(user_attributes)
        if flag
          # 如果输入了邀请码，创建好友的关系（在分销系统中体现，就是给分销resource创建一条访问记录）
          ::SalesDistribution::ResourceUser.create(resource: sale_resource, user: user) if sale_resource
        else
          error! user.errors
        end


        api_token = user.api_tokens.find_or_initialize_by(device: params[:device])
        api_token.expired_at = 30.days.since
        api_token.save
        present user, with: AppAPI::Entities::User, access_token: api_token.token, type: :private
      end

      desc '登录认证' do
        detail <<-DOC
- username/email/mobile_phone 三种登录方式只能选择一个
- 如果登录账号是手机号，需要传入手机验证码 mobile_phone_code
- 如果是其他登录账号，需要传入密码 passwrod
        DOC
        success AppAPI::Entities::User
      end
      params do
        optional :username, type: String, desc: '用户名'
        optional :email, type: String, desc: '邮箱'
        optional :mobile_phone, type: String, desc: '手机号'
        exactly_one_of :username, :email, :mobile_phone
        optional :mobile_phone_code, type: String, desc: '手机验证码'
        optional :password, type: String, desc: '登录密码'
        exactly_one_of :mobile_phone_code, :password
        optional :device, type: String, desc: '设备信息，可以是UserAgent，也可以是自定义的名字。目的是让一个设备只生成一个access token'
      end
      post :auth do
        user =
          if params[:username]
            ::User.find_by(username: params[:username])
          elsif params[:email]
            ::User.find_by(email: params[:email])
          elsif params[:mobile_phone]
            ::User.find_by_phone_number(params[:mobile_phone])
          end
        if user.nil? && (Settings.project.imolin? || Settings.project.meikemei?) && params[:mobile_phone]
          _ , user = ::User::Create.(mobile_phone: params[:mobile_phone])
          api_token = user.api_tokens.find_or_initialize_by(device: params[:device])
        end
        error! "用户不存在" if user.nil?
        if params[:password]
          error! "密码错误" unless user.valid_password?(params[:password])
        end
        if params[:mobile_phone_code] && params[:mobile_phone]
          t = Sms::Token.new(params[:mobile_phone])
          error! "验证码错误" unless t.valid?(params[:mobile_phone_code])
          t.destroy!
        end
        present user, with: AppAPI::Entities::User, access_token: user.issue_api_token(params[:device]), type: :private
      end

      desc '获取验证码' do
        detail <<-DOC
          输入手机号，获取验证码
        DOC
        # success AppAPI::Entities::User
      end
      params do
        requires :mobile_phone, type: String, desc: '手机号'
      end
      post :sms do
        # TODO: 须验证用户发送短信的频率，方式短信轰炸
        error! '请输入手机号' if params[:mobile_phone].blank?
        t = Sms::Token.new(params[:mobile_phone])
        is_dev = !(Rails.env.staging? || Rails.env.production?)
        code = is_dev ? '123456' : SecureRandom.random_number(10**8).to_s[0, 6].rjust(6, '0')
        if Settings.test_account.mobile_phone == params[:mobile_phone]
          code = Settings.test_account.code
        end
        body = Settings.mobile.auth_token_template.gsub('#code#', code)
        t.create code: code, message: body
        begin
          response = t.post!
          response.valid!
          present message: "验证码发送成功！#{is_dev ? '非生成环境虚拟验证码[123456]' : ''}"
        rescue Sms::Services::YunPianService::SentFailed
          error! '服务器出问题啦，请稍候在试！'
        end
        # error! "密码错误" unless user.valid_password?(params[:password])
        # api_token = user.api_tokens.find_or_initialize_by(device: params[:device])
        # api_token.expired_at = 30.days.since
        # api_token.save
        # present user, with: AppAPI::Entities::User, access_token: api_token.token, type: :private
      end

      desc '获取自己的用户信息' do
        success AppAPI::Entities::User
      end
      params do
        optional :stats, type: Boolean, desc: '是否显示统计数据，包括：收藏的店铺数量和产品数量，分享的帖子数量'
      end
      get 'me' do
        authenticate!
        opts = { with: AppAPI::Entities::User, type: :private }
        if params[:stats]
          opts[:site_favorites_count] = true
          opts[:product_favorites_count] = true
          opts[:article_shares_count] = true
        end
        present current_user, opts
      end

      desc '修改自己的用户信息' do
        success AppAPI::Entities::User
      end
      params do
        optional :nickname, type: String, desc: '昵称'
        # optional :username, type: String, desc: '名称'
        if Settings.project.imolin? || Settings.project.meikemei?
          optional :avatar, type: String, desc: '头像, 格式是base64'
        else
          optional :avatar, type: Rack::Multipart::UploadedFile, desc: '上传头像'
        end
        optional :mobile_phone, type: String, desc: '手机号'
        optional :mobile_phone_code, type: String, desc: '验证码'
        # all_or_none_of :mobile_phone, :mobile_phone_code
        if Settings.project.imolin?
          optional :gender, type: String, desc: '性别'
          optional :community_id, type: String, desc: '小区名称'
          optional :description, type: String, desc: '描述'
        end
      end
      put 'me' do
        authenticate!
        user = ::User.find(current_user.id) # get fresh data from DB
        if params[:avatar]
          if Settings.project.imolin? || Settings.project.meikemei?
            StringIO.open(Base64.decode64(params[:avatar])) do |data|
              data.class.class_eval { attr_accessor :original_filename, :content_type }
              data.original_filename = "user-#{user.id}.jpg"
              data.content_type = "image/jpeg"
              user.avatar = data
            end
          else
            user.avatar = ActionDispatch::Http::UploadedFile.new(params[:avatar])
          end
        end
        if params[:nickname].present?
          user.nickname = params[:nickname].strip
        end
        # if params[:username].present?
        #   user.username = params[:username].strip
        # end
        if params[:community_id].present?
          user.communities << ::Community.find_by(id: params[:community_id])
          user.user_communities.update_all(is_current: false)
          user.user_communities.where(community_id: params[:community_id]).update_all(is_current: true)
        end
        if params[:mobile_phone_code] && params[:mobile_phone]
          t = Sms::Token.new(params[:mobile_phone])
          error! "验证码错误" unless t.valid?(params[:mobile_phone_code])
          t.destroy!
          mobile = user.mobile || user.build_mobile
          mobile.phone_number = params[:mobile_phone]
          error! error: mobile.errors.messages, error_message: '手机号已经被使用' unless mobile.save
        end
        user.gender = params[:gender] if params[:gender]
        user.description = params[:description] if params[:description]
        if user.changed?
          unless user.save
            error! error: user.errors.messages, error_message: '保存失败'
          end
        end
        present user, with: AppAPI::Entities::User, type: :private
      end

      desc '获取用户信息' do
        success AppAPI::Entities::User
      end
      params do
        requires :id, type: Integer, desc: '用户ID'
      end
      get ':id' do
        present ::User.find(params[:id]), with: AppAPI::Entities::User
      end

      desc '获取用户列表' do
        success AppAPI::Entities::User.collection
      end
      params do
        use :pagination
        use :sort, fields: [:id, :created_at, :updated_at]
      end
      get do
        permission! :api_admin
        users = paginate_collection(sort_collection(::User.all), params)
        wrap_collection users, AppAPI::Entities::User
      end

    end # end of resources
  end
end
