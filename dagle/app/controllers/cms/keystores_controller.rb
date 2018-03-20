class Cms::KeystoresController < Cms::BaseController
  before_action :set_cms_site
  before_action :set_cms_keystore, only: [:show, :edit, :update, :destroy]

  def index
    authorize Cms::Keystore
    @cms_keystores = @cms_site.keystores.page(params[:page])
    respond_to do |format|
      format.html
      format.json { render json: @cms_keystores }
    end
  end

  def show
    authorize @cms_keystore
    respond_to do |format|
      format.html
      format.json { render json: @cms_keystore }
    end
  end

  def new
    authorize Cms::Keystore
    @cms_keystore = @cms_site.keystores.build
  end

  def edit
    authorize @cms_keystore
  end

  def create
    authorize Cms::Keystore
    @cms_keystore = @cms_site.keystores.new(permitted_attributes(@cms_site.keystores))
    @cms_keystore.site_id = @cms_site.id

    respond_to do |format|
      format.html do
        if @cms_keystore.save
          redirect_to cms_site_keystores_path(@cms_site), notice: '创建成功.'
        else
          render :new
        end
      end
      format.json { render json: @cms_keystore }
    end

  end

  def update
    authorize @cms_keystore
    respond_to do |format|
      format.html do
        if @cms_keystore.update(permitted_attributes(@cms_keystore))
          redirect_to cms_site_keystores_path(@cms_site), notice: ' 更新成功.'
        else
          render :edit
        end
      end
      format.json { render json: @cms_keystore }
    end
  end

  def destroy
    authorize @cms_keystore
    @cms_keystore.destroy
    respond_to do |format|
      format.html { redirect_to cms_site_keystores_url(@cms_site), notice: 'Keystore 删除成功.' }
      format.json { head 200 }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cms_keystore
      @cms_keystore = Cms::Keystore.find(params[:id])
    end

    def set_cms_site
      @cms_site = Cms::Site.find(params[:site_id])
    end
    # Only allow a trusted parameter "white list" through.
    # def cms_keystore_params
    #   params.require(:cms_keystore).permit(:site_id, :key, :value, :description)
    # end
end
