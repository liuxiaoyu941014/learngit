# csv support
require 'csv'
class Admin::MembersController < Admin::BaseController
  before_action :set_site, only: [:index, :show, :new, :edit, :create, :update, :destroy]
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  def dashboard
    authorize @site.members
  end

  # GET /admin/members
  def index
    authorize @site.members
    @filter_colums = %w(name qq email)
    @members = build_query_filter(@site.members.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@members.to_json, filename: "members-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@members.to_xml, filename: "members-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@members.as_csv(), filename: "members-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/members/1
  def show
    authorize @member
  end

  # GET /admin/members/new
  def new
    authorize @site.members
    @member = @site.members.new
  end

  # GET /admin/members/1/edit
  def edit
    authorize @member
  end

  # POST /admin/members
  def create
    authorize @site.members
    flag, @member = Member::Create.(permitted_attributes(@site.members).merge(site_id: @site.id))
    if flag
      redirect_to admin_site_member_path(@site, @member), notice: 'Member 创建成功.'
    else
      render :new
    end
  end

  # PATCH/PUT /admin/members/1
  def update
    authorize @member
    flag, @member = Member::Update.(@member, (permitted_attributes(@member)))
    if flag
      redirect_to admin_site_member_path(@site, @member), notice: 'Member 更新成功.'
    else
      render :edit
    end
  end

  # DELETE /admin/members/1
  def destroy
    authorize @member
    Member::Destroy.(@member)
    redirect_to admin_site_members_url(@site), notice: 'Member 删除成功.'
  end

  def all
    authorize Member
    @filter_colums = %w(name qq email)
    @members = build_query_filter(Member.all, only: @filter_colums).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@members.to_json, filename: "members-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@members.to_xml, filename: "members-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@members.as_csv(only: []), filename: "members-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = @site.members.find(params[:id])
    end

    def set_site
      @site = Site.find(params[:site_id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_member_params
    #       #   params[:admin_member]
    #       # end
end
