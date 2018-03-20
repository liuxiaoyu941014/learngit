class Admin::HomeController < Admin::BaseController
  skip_after_action :verify_authorized
  def index
  end
end
