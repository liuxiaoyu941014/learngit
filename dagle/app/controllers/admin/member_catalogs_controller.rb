# csv support
require 'csv'
class Admin::MemberCatalogsController < Admin::BaseController
  before_action :set_member_catalog, only: [:show, :edit, :update, :destroy]

  # GET /admin/member_catalogs
  def index
    authorize MemberCatalog
    @filter_colums = %w(id)
    @member_catalogs = build_query_filter(MemberCatalog.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@member_catalogs.to_json, filename: "member_catalogs-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@member_catalogs.to_xml, filename: "member_catalogs-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@member_catalogs.as_csv(), filename: "member_catalogs-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/member_catalogs/1
  def show
    authorize @member_catalog
  end

  # GET /admin/member_catalogs/new
  def new
    authorize MemberCatalog
    @member_catalog = MemberCatalog.new
  end

  # GET /admin/member_catalogs/1/edit
  def edit
    authorize @member_catalog
  end

  # POST /admin/member_catalogs
  def create
    authorize MemberCatalog
    @member_catalog = MemberCatalog.new(permitted_attributes(MemberCatalog))

    if @member_catalog.save
      redirect_to admin_member_catalog_path(@member_catalog), notice: "#{MemberCatalog.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/member_catalogs/1
  def update
    authorize @member_catalog
    if @member_catalog.update(permitted_attributes(@member_catalog))
      redirect_to admin_member_catalog_path(@member_catalog), notice: "#{MemberCatalog.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/member_catalogs/1
  def destroy
    authorize @member_catalog
    @member_catalog.destroy
    redirect_to admin_member_catalogs_url, notice: "#{MemberCatalog.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member_catalog
      @member_catalog = MemberCatalog.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_member_catalog_params
    #       #   params.require(:admin_member_catalog).permit(policy(@admin_member_catalog).permitted_attributes)
    #       # end
end
