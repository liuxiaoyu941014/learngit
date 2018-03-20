# csv support
require 'csv'
class Admin::Cms::ChannelsController < Admin::Cms::BaseController
  before_action :set_site
  before_action :set_cms_channel, only: [:show, :edit, :update, :destroy]

  # GET /admin/cms/channels
  def index
    authorize ::Cms::Channel
    @filter_colums = %w(title short_title)
    @cms_channels = build_query_filter(@cms_site.channels.where('parent_id is null').order("id ASC"), only: @filter_colums).page(params[:page])
    @cms_page = @cms_channels.build
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@cms_channels.to_json, filename: "cms_channels-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@cms_channels.to_xml, filename: "cms_channels-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@cms_channels.as_csv(only: []), filename: "cms_channels-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
        format.json {render json: @cms_site.channels.select{|channel| !channel.new_record?}.as_json(only: [:id, :title])}
      end
    end
  end

  # GET /admin/cms/channels/1
  def show
    authorize @cms_channel

    @filter_colums = %w(id)
    @cms_pages = build_query_filter(::Cms::Page.joins(:channel).where("cms_channels.site_id = ? AND cms_channels.id = ?", @cms_site.id, @cms_channel.id), only: @filter_colums).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@cms_pages.to_json, filename: "cms_pages-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@cms_pages.to_xml, filename: "cms_pages-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@cms_pages.as_csv(only: []), filename: "cms_pages-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/cms/channels/new
  def new
    authorize ::Cms::Channel
    @cms_channel = ::Cms::Channel.new
  end

  # GET /admin/cms/channels/1/edit
  def edit
    authorize @cms_channel
  end

  # POST /admin/cms/channels
  def create
    authorize ::Cms::Channel
    @cms_channel = ::Cms::Channel.new(permitted_attributes(::Cms::Channel))
    @cms_channel.site_id = @cms_site.id
    if @cms_channel.save
      redirect_to admin_cms_site_channel_path(@cms_site, @cms_channel), notice: "#{::Cms::Channel.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/cms/channels/1
  def update
    authorize @cms_channel
    @cms_channel.site_id = @cms_site.id
    if @cms_channel.update(permitted_attributes(@cms_channel))
      redirect_to admin_cms_site_channels_path(@cms_site), notice: "#{::Cms::Channel.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/cms/channels/1
  def destroy
    authorize @cms_channel
    @cms_channel.destroy
    redirect_to admin_cms_site_channels_url(@cms_site), notice: "#{::Cms::Channel.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_channel
      @cms_channel = ::Cms::Channel.find(params[:id])
    end

    def set_site
      @cms_site = ::Cms::Site.find(params[:site_id])
    end
end
