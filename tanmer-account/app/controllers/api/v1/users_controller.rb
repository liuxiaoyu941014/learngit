class Api::V1::UsersController < Api::V1::BaseController
  def profile
    render json: current_user.api_json(with_permissions: true)
    # current_user.of_app current_app do |user|
    #   render json: user.as_json(only: [:name, :email, :image], methods: [:uid, :permission_keys])
    # end
    # j = current_user.as_json(only: [:name, :email, :image], methods: [:uid, :app_permission_keys], app: current_app)
    # render json: j
  end

end
