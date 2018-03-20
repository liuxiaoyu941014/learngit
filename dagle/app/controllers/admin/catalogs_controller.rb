class Admin::CatalogsController < Admin::BaseController
  before_action :set_catalog_model
  before_action :set_admin_catalog, only: [:edit, :update, :destroy]

  # GET /admin/catalogs
  def index
    authorize catalog_model
    respond_to do |format|
      format.html
      format.json do
        @catalogs = catalog_model.roots
        render json: @catalogs
      end
    end
  end

  # GET /admin/catalogs/1
  def show
    authorize @admin_catalog
  end

  # GET /admin/catalogs/new
  def new
    authorize catalog_model
    @admin_catalog = catalog_model.new
  end

  # GET /admin/catalogs/1/edit
  def edit
    authorize @admin_catalog
  end

  # POST /admin/catalogs
  def create
    authorize catalog_model
    flag, @admin_catalog = catalog_model::Create.(admin_catalog_params)
    if flag
      render json: @admin_catalog
    else
      render json: @admin_catalog.errors, status: :failed
    end
  end

  # PATCH/PUT /admin/catalogs/1
  def update
    authorize @admin_catalog
    flag, @admin_catalog = catalog_model::Update.(@admin_catalog, admin_catalog_params)
    if flag
      head :ok
    else
      render json: @admin_catalog.errors.as_json, status: :failed
    end
  end

  # DELETE /admin/catalogs/1
  def destroy
    authorize @admin_catalog
    catalog_model::Destroy.(@admin_catalog)
    head :ok
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_catalog
      @admin_catalog = catalog_model.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def admin_catalog_params
      params.permit(:parent_id, :name, :position, :settings, :icon_url, :is_hot)
    end

    def catalog_model
      @catalog_model
    end

    def set_catalog_model
      @catalog_model = params[:klass] ? params[:klass].constantize : Catalog
    end
end
