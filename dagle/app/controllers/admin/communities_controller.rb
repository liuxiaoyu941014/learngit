# csv support
require 'csv'
class Admin::CommunitiesController < Admin::BaseController
  before_action :set_community, only: [:show, :edit, :update, :destroy]

  # GET /admin/communities
  def index
    authorize Community
    @filter_colums = %w(id name address_line)
    @communities = build_query_filter(Community.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@communities.to_json, filename: "communities-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@communities.to_xml, filename: "communities-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@communities.as_csv(), filename: "communities-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/communities/1
  def show
    authorize @community
    #查找社区周边的商家(site), 按就近排序
    @sites = Site.near_by(lat: @community.address_lat, lng: @community.address_lng, distance: 2000).page(params[:page]).per(9) if params[:sites]
    @sites_string = @sites.to_json(only: [:id], methods: [:address_lat, :address_lng])
  end

  # GET /admin/communities/new
  def new
    authorize Community
    @community = Community.new
  end

  # GET /admin/communities/1/edit
  def edit
    authorize @community
  end

  # POST /admin/communities
  def create
    authorize Community
    flag, @community = Community::Create.(permitted_attributes(Community).merge(updated_by: current_user.id))

    if flag
      redirect_to admin_community_path(@community), notice: "#{Community.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/communities/1
  def update
    authorize @community
    # if params[:community][:lat].present? &&  params[:community][:lat].present?
      # manual_geo = @community.manual_geo || @community.build_manual_geo
      # manual_geo.lat = params[:community][:lat]
      # manual_geo.lng = params[:community][:lng]
      # manual_geo.save! if manual_geo.changed?
      # address = Gnomon::Address.resolve(lat: params[:community][:lat], lng: params[:community][:lng])
      # @community.address = address
    # end
    flag, @community = Community::Update.(@community, permitted_attributes(@community).merge(updated_by: current_user.id))
    if flag
      redirect_to admin_community_path(@community), notice: "#{Community.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/communities/1
  def destroy
    authorize @community
    @community.destroy
    redirect_to admin_communities_url, notice: "#{Community.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_community
      @community = Community.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_community_params
    #       #   params.require(:admin_community).permit(policy(@admin_community).permitted_attributes)
    #       # end
end
