class Users::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  ##
  # User register with mobile number
  #
  # Post /sign_up
  #
  # params:
  #   user  - with two attributes :mobile, :code
  #
  # = Examples
  #
  #   resp = conn.post("/sign_up", {"user" => {"mobile" => '18687878787', "code" => '1234'}})
  #   resp.body
  #   => {}
  #
  #   resp = conn.post("/sign_up", {"user" => {"mobile" => '18687878787', "code" => '1235'}})
  #   resp.body
  #   => {error: '验证码不正确！'}
  #
  #   resp = conn.post("/sign_up", {"user" => {"mobile" => '18688787', "code" => '1234'}})
  #   resp.body
  #   => {error: '创建失败了，请检查！'}
  #
  def create
    if params[:user][:mobile].present?
      sign_up_with_mobile(params[:user][:mobile], params[:user][:code])
    elsif params[:user][:email].present?
      sign_up_with_email(params[:user][:email], params[:user][:password], params[:user][:password_confirmation])
    elsif params[:user][:weixin_code].present?
      conn = Faraday.new(:url => Settings.weixin_login.host)
      response = conn.get('/wx/mp_auth/%s/fetch_uid/%s' % [Settings.weixin_login.appid, params[:user][:weixin_code]])
      data = JSON.parse(response.body)
      if data['uid']
        sign_up_with_weixin(data['uid'])
      else
        render json: { error: '微信注册失败,请重试' }
      end
    end
  end

  private
  def sign_up_with_mobile(mobile, code)
    t = Sms::Token.new(mobile)
    if t.valid?(code)
      user_attributes = {}
      user_attributes[:mobile_phone] = mobile
      # user_attributes[:role_ids] = Role.where(name: 'agent').map(&:id) if session["agent"]
      flag, user = User::Create.(user_attributes)
      if flag
        if session["weixin_uid"]
          weixin_user = User::Weixin.find_by_uid(session["weixin_uid"])
          weixin_user.user = user
          weixin_user.save!
          session["weixin_uid"] = nil
        end
        sign_in user, :event => :authentication #this will throw if @user is not activate
        render json: {}
      else
        render json: {error: user.errors.full_messages.join(",") }
      end
    else
      render json: {error: '验证码不正确！'}
    end
  end

  def sign_up_with_email(email, password, password_confirmation)
    user = User.new(email: email, password: password, password_confirmation: password_confirmation)
    if user.save
      sign_in user, :event => :authentication
      render json: {}
    else
      render json: {error: user.errors.full_messages.join(',')}
    end
  end

  def sign_up_with_weixin(uid)
    user = User.new
    weixin = User::Weixin.find_or_initialize_by(uid: uid)
    if weixin.new_record?
      user.password ||= Devise.friendly_token[0,20]
      user.weixin = weixin
      user.nickname = weixin.name
      if user.save
        sign_in user, :event => :authentication
        render json: {} 
      else
        render json: {error: user.errors.full_messages.join(',')}
      end
    else
      user.errors.add :weixin, '已经存在'
      render json: {error: user.errors.full_messages.join(',')}
    end
  end

end
