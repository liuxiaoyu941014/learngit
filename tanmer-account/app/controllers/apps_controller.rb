class AppsController < Doorkeeper::ApplicationsController
  layout 'application'
  check_authorization

  def index
    authorize! :show, Doorkeeper::Application
    @applications = model_scope.all.order(id: :desc)
    super
  end

  def show
    authorize! :show, @application
    # authorize! :show, Doorkeeper::Application
  end

  def new
    authorize! :create, Doorkeeper::Application
    super
    @application.scopes = Doorkeeper.configuration.default_scopes.to_s
  end

  def create
    authorize! :create, Doorkeeper::Application
    super
  end

  def edit
    authorize! :update, @application
  end

  def update
    authorize! :update, @application
    super
  end

  def destroy
    authorize! :destroy, @application
    if @application.id == Doorkeeper::Application::MAIN_ID
      flash[:alert] = I18n.t(:cannot_destroy_main_app, scope: [:doorkeeper, :flash, :applications, :destroy])
    else
      flash[:notice] = I18n.t(:notice, scope: [:doorkeeper, :flash, :applications, :destroy]) if @application.destroy
    end
    redirect_to oauth_applications_url
  end

  private

  def application_params
    d = params.require(:doorkeeper_application).permit(:name, :redirect_uri, :scopes, :source_urls, :oauth_expiration, :is_sso)
    d[:oauth_expiration] = nil if d[:oauth_expiration].to_i <= 0
    d
  end

  def set_application
    @application = model_scope.find(params[:id])
  end

  def model_scope
    Doorkeeper::Application.where(owner: nil).order(id: :desc)
  end
end
