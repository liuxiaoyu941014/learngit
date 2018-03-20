class Users::Weixins::RegistrationsController < ApplicationController

  def new
    respond_to do |format|
      format.png do
        qrcode = RQRCode::QRCode.new(users_weixins_registrations_url)
        send_data qrcode.as_png(
          resize_gte_to: false,
          resize_exactly_to: false,
          fill: 'white',
          color: 'black',
          size: 240,
          border_modules: 4,
          module_px_size: 6,
          file: nil
        )        
      end
    end
  end

  def show
    if session["weixin_uid"]
      weixin_user = User::Weixin.find_by_uid(session["weixin_uid"])
      if weixin_user.user
        sign_in_and_redirect weixin_user.user
      else
        session["agent"] = 'agent' if params[:agent].present?
        redirect_to sign_up_url
      end
    else
      redirect_to user_wechat_omniauth_authorize_url(origin: request.original_url)
    end    
  end


end