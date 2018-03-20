# csv support
require 'csv'
class Admin::Forage::SourcesController < Admin::BaseController
  before_action :set_forage_source, only: [:show, :edit, :update, :destroy]

  # GET /admin/forage/sources
  def index
    authorize ::Forage::Source
    @filter_colums = %w(id)
    @forage_sources = build_query_filter(::Forage::Source.all, only: @filter_colums).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@forage_sources.to_json, filename: "forage_sources-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@forage_sources.to_xml, filename: "forage_sources-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@forage_sources.as_csv(only: []), filename: "forage_sources-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/forage/sources/1
  def show
    authorize @forage_source
  end

  # GET /admin/forage/sources/new
  def new
    authorize ::Forage::Source
    @forage_source = ::Forage::Source.new
  end

  # GET /admin/forage/sources/1/edit
  def edit
    authorize @forage_source
  end

  # POST /admin/forage/sources
  def create
    authorize ::Forage::Source
    @forage_source = ::Forage::Source.new(permitted_attributes(::Forage::Source))

    if @forage_source.save
      redirect_to admin_forage_source_path(@forage_source), notice: "#{::Forage::Source.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/forage/sources/1
  def update
    authorize @forage_source
    if @forage_source.update(permitted_attributes(@forage_source))
      redirect_to admin_forage_source_path(@forage_source), notice: "#{::Forage::Source.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/forage/sources/1
  def destroy
    authorize @forage_source
    @forage_source.destroy
    redirect_to admin_forage_sources_url, notice: "#{::Forage::Source.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forage_source
      @forage_source = ::Forage::Source.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_forage_source_params
    #       #   params[:admin_forage_source]
    #       # end
end
