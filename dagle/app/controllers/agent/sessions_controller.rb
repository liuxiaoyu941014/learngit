class Agent::SessionsController < Agent::BaseController
  def new
    @user = User.new
  end
end
