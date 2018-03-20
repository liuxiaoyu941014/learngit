# csv support
require 'csv'
class Admin::Forage::DetailsController < Admin::BaseController
  before_action :set_forage_detail, only: [:show, :edit, :update, :destroy]

  # GET /admin/forage/details
  def index
    authorize ::Forage::Detail
    @filter_colums = %w(id)
    @forage_details = build_query_filter(Forage::Detail.all, only: @filter_colums).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@forage_details.to_json, filename: "forage_details-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@forage_details.to_xml, filename: "forage_details-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@forage_details.as_csv(only: []), filename: "forage_details-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/forage/details/1
  def show
    authorize @forage_detail
  end

  # GET /admin/forage/details/new
  def new
    authorize ::Forage::Detail
    @forage_detail = Forage::Detail.new
  end

  # GET /admin/forage/details/1/edit
  def edit
    authorize @forage_detail
  end

  # POST /admin/forage/details
  def create
    authorize Forage::Detail
    @forage_detail = Forage::Detail.new(permitted_attributes(Forage::Detail))

    if @forage_detail.save
      redirect_to admin_forage_detail_path(@forage_detail), notice: "#{Forage::Detail.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/forage/details/1
  def update
    authorize @forage_detail
    if @forage_detail.update(permitted_attributes(@forage_detail))
      redirect_to admin_forage_detail_path(@forage_detail), notice: "#{Forage::Detail.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/forage/details/1
  def destroy
    authorize @forage_detail
    @forage_detail.destroy
    redirect_to admin_forage_details_url, notice: "#{Forage::Detail.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forage_detail
      @forage_detail = Forage::Detail.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_forage_detail_params
    #       #   params.require(:admin_forage_detail).permit(policy(@admin_forage_detail).permitted_attributes)
    #       # end
end
