class Api::V1::UsersController < Api::BaseController
  before_action :authenticate!

  def index
    # authorize User
    page_size = params[:page_size].present? ? params[:page_size].to_i : 20
    users =  params[:role].present? ? User.with_role(params[:role]) : User.all
    users = users.order(created_at: :desc).page(params[:page] || 1).per(page_size)
    render json: {
      users: users.as_json(only: %w(id nickname)),
      page_size: page_size,
      current_page: users.current_page,
      total_pages: users.total_pages,
      total_count: users.total_count
    }
  end
end
