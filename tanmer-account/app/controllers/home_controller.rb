class HomeController < ApplicationController
  skip_authorization_check only: [:index, :healthz, :agreement, :privacy]
  skip_before_action :ensure_login!, only: [:healthz, :agreement, :privacy]

  def index
  end

  def healthz
    render plain: 'OK'
  end
end
