class Agent::CatalogsController < Agent::BaseController
  before_action :set_catalog_model

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

  private

    def set_catalog_model
      @catalog_model = params[:klass].constantize
    end

    def catalog_model
      @catalog_model
    end
end
