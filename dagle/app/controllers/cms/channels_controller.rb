class Cms::ChannelsController < Cms::BaseController
  before_action :set_cms_site
  before_action :set_cms_channel, only: [:show, :edit, :update, :destroy]

  def index
    @cms_channels = @cms_site.channels.where("parent_id is null").page(params[:page])
    authorize @cms_channels
    respond_to do |format|
      format.html
      format.json { render json: @cms_channels }
    end
  end

  def show
    authorize @cms_channel
    @cms_pages = @cms_channel.pages.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @cms_channel }
    end
  end

  def new
    authorize @cms_site.channels
    @cms_channel = Cms::Channel.new
  end

  def edit
    authorize @cms_channel
  end

  def create
    @cms_channel = @cms_site.channels.new(permitted_attributes(@cms_site.channels))
    authorize @cms_channel
    respond_to do |format|
      format.html do
        if @cms_channel.save
          redirect_to cms_site_channel_path(@cms_site, @cms_channel), notice: 'Channel 创建成功.'
        else
          render :new
        end
      end
      format.json { render json: @cms_channel }
    end

  end

  def update
    authorize @cms_channel
    respond_to do |format|
      format.html do
        if @cms_channel.update(permitted_attributes(@cms_channel))
          redirect_to cms_site_channel_path(@cms_site, @cms_channel), notice: 'Channel 更新成功.'
        else
          render :edit
        end
      end
      format.json { render json: @cms_channel }
    end
  end

  def destroy
    authorize @cms_channel
    @cms_channel.destroy
    respond_to do |format|
      format.html { redirect_to cms_site_url(@cms_site), notice: 'Channel 删除成功.' }
      format.json { head 200 }
    end

  end

  private
    def set_cms_site
      @cms_site = Cms::Site.find(params[:site_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_channel
      @cms_channel = @cms_site.channels.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def cms_channel_params
    #       #   params.require(:cms_channel).permit(:site_id, :parent_id, :title, :short_title, :properties, :tmp_index, :tmp_detail, :keywords, :description, :image_path, :content)
    #       # end
end
