# csv support
require 'csv'
class Admin::Forage::SimplesController < Admin::BaseController
  before_action :set_forage_simple, only: [:show, :edit, :update, :destroy]

  # GET /admin/forage/simples
  def index
    authorize ::Forage::Simple
    @filter_colums = %w(id)
    @forage_simples = build_query_filter(Forage::Simple.all, only: @filter_colums).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@forage_simples.to_json, filename: "forage_simples-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@forage_simples.to_xml, filename: "forage_simples-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@forage_simples.as_csv(only: []), filename: "forage_simples-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/forage/simples/1
  def show
    authorize @forage_simple
  end

  # GET /admin/forage/simples/new
  def new
    authorize Forage::Simple
    @forage_simple = Forage::Simple.new
  end

  # GET /admin/forage/simples/1/edit
  def edit
    authorize @forage_simple
  end

  # POST /admin/forage/simples
  def create
    authorize Forage::Simple
    @forage_simple = Forage::Simple.new(permitted_attributes(Forage::Simple))

    if @forage_simple.save
      redirect_to admin_forage_simple_path(@forage_simple), notice: "#{Forage::Simple.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/forage/simples/1
  def update
    authorize @forage_simple
    if @forage_simple.update(permitted_attributes(@forage_simple))
      redirect_to admin_forage_simple_path(@forage_simple), notice: "#{Forage::Simple.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/forage/simples/1
  def destroy
    authorize @forage_simple
    @forage_simple.destroy
    redirect_to admin_forage_simples_url, notice: "#{Forage::Simple.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forage_simple
      @forage_simple = Forage::Simple.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_forage_simple_params
    #       #   params.require(:admin_forage_simple).permit(policy(@admin_forage_simple).permitted_attributes)
    #       # end
end
