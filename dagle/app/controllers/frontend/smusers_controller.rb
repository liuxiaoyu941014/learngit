class Frontend::SmusersController < Frontend::BaseController
    skip_before_action :verify_authenticity_token, :only => [:headshot]
    before_action :ensure_login!
    def index
    end
   
    def show
      
    end
  
    def edit
      authorize current_user
     
    end
    def update
      authorize @current_user
      @current_user = User.find(params[:id])
      if @current_user.update(current_user_params)
        redirect_to frontend_smusers_path
      else
        render json: {errors:  @current_user.errors.full_messages.join(',')}
      end
    end
  
    def self_order
      if ['pending', 'open', 'paid', 'completed', 'cancelled'].include?(params[:type])
        @user_orders = current_user.orders.where(status: params[:type]).order("updated_at DESC").page(params[:page])
      else
        @user_orders = current_user.orders.order("updated_at DESC").page(params[:page])
      end
     
     
    end
  
    def self_comment
      if params[:type]
        @comments = Comment::Entry.where(user_id: current_user.id, resource_type: params[:type]).order("updated_at DESC").page(params[:page])
      else
        @comments = Comment::Entry.where(user_id: current_user.id).order("updated_at DESC").page(params[:page])
      end
      @product_comments = @comments.group_by{|c| c.resource}
    end
  
    def self_complaint
      @complaint = Complaint.new
      if params[:complaint]
        complaint = Complaint.new(user_id: current_user.id, reason: params[:complaint][:reason], complaint_type: "feedback")
        if complaint.save
          redirect_to users_path(current_user), notice: "发布成功"
        else
          render
        end
      end
    end
  
    def self_message
      if params[:type] == 'unread'
        @notifications = Notification.where(user: current_user).unread.order('updated_at DESC')
        Notification.read!(@notifications.select(&:id))    
      else
        @notifications = Notification.where(user: current_user).where("read_at is not null").order('updated_at DESC')
      end
    end
  
    def ensure_login!
      redirect_to root_url unless current_user
    end
  
    def binding_phone
      @return_url = params[:return_url] if params[:return_url].present?
      if params['user']
        t = Sms::Token.new(params['user']['mobile'])
        if t.valid?(params['user']['code'])
          t.destroy!
          mobile_user = User::Mobile.find_by(phone_number: params['user']['mobile']).try(:user)
          if mobile_user
            if mobile_user.id != current_user.id
              if current_user.mobile
                render json: {error: '您有两个手机账号!'}  
              else
                if current_user.weixin && !mobile_user.weixin
                  mobile_user.create_weixin(uid: current_user.weixin.uid)
                end
                current_user.destroy!
                sign_in mobile_user
                render json: {}
              end
            else
              render json: {error: '您已经绑定了该手机号!'}
            end
          else
            mobile = current_user.mobile || current_user.build_mobile
            mobile.phone_number = params['user']['mobile']
            if mobile.save
              render json: {}
            else
              render json: {error: mobile.errors.full_messages}
            end
          end
        else
          render json: {error: '验证码不正确！'}
        end
      end
    end
  
    def binding_weixin
      if params[:code]
        conn = Faraday.new(:url => Settings.weixin_login.host)
        response = conn.get('/wx/mp_auth/%s/fetch_uid/%s' % [Settings.weixin_login.appid, params[:code]])
        data = JSON.parse(response.body)
        if data['uid']
          current_user.weixin = User::Weixin.find_or_create_by(uid: data['uid'])
          render json: { success: true }
        else
          render json: { success: false }
        end
      end
    end
  
    def headshot
      if params[:user][:attachments]
        @current_user.avatar = JSON.parse(params[:user][:attachments])["output"]["image"]
        @current_user.avatar_file_name = JSON.parse(params[:user][:attachments])["input"]["name"]
      end
      if @current_user.save
        render json: { success: true , url: current_user.display_headshot }
      else
        render :edit
      end
    end
  
  end
  private
  def current_user_params
    params.require(:user).permit(:nickname, :email, :relname, :cardnu, :locity, :birth, :sex)
  end
