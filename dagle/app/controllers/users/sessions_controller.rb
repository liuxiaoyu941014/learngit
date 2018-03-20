class Users::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session, if: Proc.new { |c| c.request.format == 'application/json' }
  ##
  # User login with mobile number
  #
  # Post /sign_in
  #
  # params:
  #   user  - with two attributes :mobile, :code
  #
  # = Examples
  #
  #   resp = conn.post("/sign_in", {"user" => {"mobile" => '18687878787', "code" => '1234'}})
  #   resp.body
  #   => {}
  #
  #   resp = conn.post("/sign_up", {"user" => {"mobile" => '18688787', "code" => '1235'}})
  #   resp.body
  #   => {error: '验证码错误！'}
  #
  #   resp = conn.post("/sign_up", {"user" => {"mobile" => 'aaaaaaaaaaa', "code" => '1234'}})
  #   resp.body
  #   => {error: '账号不可用！'}
  #
  #   resp = conn.post("/sign_in", {"user" => {"name" => 'test',}})
  #   resp.body
  #   => {error: '只支持手机号登录！'}
  #
  def create
    if params[:user][:mobile].present?
      login_with_mobile(params[:user][:mobile], params[:user][:code])
    elsif params[:user][:email].present?
      login_with_email(params[:user][:email], params[:user][:password])
    else
      render json: {error: '只支持手机号,邮箱登录！'}
    end
  end

  def impersonate
    user = User.find(params[:id])
    authorize user
    impersonate_user(user)
    if user.super_admin_or_admin?
      redirect_to admin_root_url
    elsif user.has_role?(:agent)
      redirect_to agent_root_url
    else
      redirect_to root_path
    end
  end

  def stop_impersonating
    stop_impersonating_user
    redirect_to root_path
  end

  private
    ##
    # User login with mobile
    # @param mobile [String] require a mobile number
    # @param code [String] auth code
    # @return [JSON] return json data, if user verification failed, renturn json data with :error option.
    #
    def login_with_mobile(mobile, code)
      if current_user != true_user
        stop_impersonating_user
      end
      user = User::Mobile.find_by(phone_number: mobile).try(:user)
      if user
        t = Sms::Token.new(mobile)
        if t.valid?(code)
          sign_in user
          url = 
            if user.super_admin_or_admin? || user.permission?(:login_admin)
              admin_root_url
            elsif user.has_role?(:agent)
              agent_root_url
            else
              root_url
            end
          render json: {url: url}
        else
          render json: {error: '验证码错误！'}
        end
      else
        render json: {error: '账号不可用！'}
      end
    end

    def login_with_email(email, password)
      if current_user != true_user
        stop_impersonating_user
      end
      user = User.find_by(email: email)
      if user
        if user.valid_password?(password)
          sign_in user
          url = 
            if user.super_admin_or_admin? || user.permission?(:login_admin)
              admin_root_url
            elsif user.has_role?(:agent)
              agent_root_url
            else
              root_url
            end
          render json: {url: url}
        else
          render json: {error: '密码错误！'}
        end
      else
        render json: {error: '账号不可用！'}
      end
    end

    def pundit_user
      if %w(impersonate stop_impersonating).include?(action_name)
        true_user
      else
        current_user
      end
    end
end
