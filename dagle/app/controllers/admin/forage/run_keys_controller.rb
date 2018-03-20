# csv support
require 'csv'
class Admin::Forage::RunKeysController < Admin::BaseController
  before_action :set_forage_run_key, only: [:show, :edit, :update, :destroy]

  # GET /admin/forage/run_keys
  def index
    authorize ::Forage::RunKey
    @filter_colums = %w(id)
    @forage_run_keys = build_query_filter(::Forage::RunKey.all, only: @filter_colums).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@forage_run_keys.to_json, filename: "forage_run_keys-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@forage_run_keys.to_xml, filename: "forage_run_keys-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@forage_run_keys.as_csv(only: []), filename: "forage_run_keys-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/forage/run_keys/1
  def show
    authorize @forage_run_key
  end

  # GET /admin/forage/run_keys/new
  def new
    authorize ::Forage::RunKey
    @forage_run_key = ::Forage::RunKey.new
  end

  # GET /admin/forage/run_keys/1/edit
  def edit
    authorize @forage_run_key
  end

  # POST /admin/forage/run_keys
  def create
    authorize ::Forage::RunKey
    @forage_run_key = ::Forage::RunKey.new(permitted_attributes(::Forage::RunKey))

    if @forage_run_key.save
      redirect_to admin_forage_run_key_path(@forage_run_key), notice: "#{::Forage::RunKey.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/forage/run_keys/1
  def update
    authorize @forage_run_key
    if @forage_run_key.update(permitted_attributes(@forage_run_key))
      redirect_to admin_forage_run_key_path(@forage_run_key), notice: "#{::Forage::RunKey.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/forage/run_keys/1
  def destroy
    authorize @forage_run_key
    @forage_run_key.destroy
    redirect_to admin_forage_run_keys_url, notice: "#{::Forage::RunKey.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_forage_run_key
      @forage_run_key = ::Forage::RunKey.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_forage_run_key_params
    #       #   params.require(:admin_forage_run_key).permit(policy(@admin_forage_run_key).permitted_attributes)
    #       # end
end
