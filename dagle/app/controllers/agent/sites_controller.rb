class Agent::SitesController < Agent::BaseController
  skip_before_action :set_current_site
  before_action :set_site, only: [:show, :edit, :update, :destroy, :binding_wx_callback]
  before_action :set_delivery_fee, only: [:create, :update]

  def index
    @agent_sites = @site.sites
  end

  def new
    authorize Site
    @agent_site = Site.new
  end

  def edit
    @agent_site = Site.find(params[:id])
    authorize @agent_site
  end

  def create
    @agent_site = Site.new(permitted_attributes(Site))
    @agent_site.user_id = current_user.id
    @agent_site.address_line = '成都市'
    authorize @agent_site

    respond_to do |format|
      format.html do
        if @agent_site.save
          redirect_to agent_root_path, notice: '创建成功.'
        else
          render :new
        end
      end
      format.json { render json: @agent_site }
    end

  end

  def update
    authorize @agent_site
    respond_to do |format|
      format.html do
        if @agent_site.update(permitted_attributes(@agent_site))
          redirect_to agent_root_path, notice: '更新成功.'
        else
          render :edit
        end
      end
      format.json { render json: @agent_site }
    end
  end

  def binding_wx_callback
    conn = Faraday.new(:url => 'https://wxopen.tanmer.com')
    if params[:code] 
      code = params[:code]
      response = conn.get("api/mp/token?code=#{code}&name=#{@agent_site.title}")
      data = JSON.parse(response.body)
      @agent_site.tanmer_wxopen_token = data['token']
      @agent_site.save!
      redirect_to agent_site_path(@agent_site)
    elsif params[:site][:tanmer_wxopen_token]
      submit_token = params[:site][:tanmer_wxopen_token]
      conn.headers[Faraday::Request::Authorization::KEY] = "Bear #{submit_token}"
      response = conn.get("api/mp/info")
      data = JSON.parse(response.body)
      if data['code'] == -1
        render js: "alert('输入的token错误，请检查后重新输入');"
      else
        @agent_site.tanmer_wxopen_token = submit_token
        @agent_site.save!
        redirect_to agent_site_path(@agent_site)
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_site
      @agent_site = Site.find_by!(user_id: current_user.id)
    end

    def set_delivery_fee
      params[:site][:delivery_fee] = params[:site][:delivery_fee].to_f * 100 unless params[:site][:delivery_fee].blank?
    end
    # Only allow a trusted parameter "white list" through.

end
