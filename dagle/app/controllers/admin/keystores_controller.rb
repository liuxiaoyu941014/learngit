# csv support
require 'csv'
class Admin::KeystoresController < Admin::BaseController
  before_action :set_keystore, only: [:show, :edit, :update, :destroy]

  # GET /admin/keystores
  def index
    authorize Keystore
    @filter_colums = %w(id)
    @keystores = build_query_filter(Keystore.all, only: @filter_colums).order(updated_at: :desc).page(params[:page])
    respond_to do |format|
      if params[:json].present?
        format.html { send_data(@keystores.to_json, filename: "keystores-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.json") }
      elsif params[:xml].present?
        format.html { send_data(@keystores.to_xml, filename: "keystores-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.xml") }
      elsif params[:csv].present?
        # as_csv =>  () | only: [] | except: []
        format.html { send_data(@keystores.as_csv(), filename: "keystores-#{Time.now.localtime.strftime('%Y%m%d%H%M%S')}.csv") }
      else
        format.html
      end
    end
  end

  # GET /admin/keystores/1
  def show
    authorize @keystore
  end

  # GET /admin/keystores/new
  def new
    authorize Keystore
    @keystore = Keystore.new
  end

  # GET /admin/keystores/1/edit
  def edit
    authorize @keystore
  end

  # POST /admin/keystores
  def create
    authorize Keystore
    @keystore = Keystore.new(permitted_attributes(Keystore))

    if @keystore.save
      redirect_to admin_keystore_path(@keystore), notice: "#{Keystore.model_name.human} 创建成功."
    else
      render :new
    end
  end

  # PATCH/PUT /admin/keystores/1
  def update
    authorize @keystore
    if @keystore.update(permitted_attributes(@keystore))
      redirect_to admin_keystore_path(@keystore), notice: "#{Keystore.model_name.human} 更新成功."
    else
      render :edit
    end
  end

  # DELETE /admin/keystores/1
  def destroy
    authorize @keystore
    @keystore.destroy
    redirect_to admin_keystores_url, notice: "#{Keystore.model_name.human} 删除成功."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_keystore
      @keystore = Keystore.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    # def admin_keystore_params
    #       #   params.require(:admin_keystore).permit(policy(@admin_keystore).permitted_attributes)
    #       # end
end
