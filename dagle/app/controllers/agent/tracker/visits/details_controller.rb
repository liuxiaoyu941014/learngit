class Agent::Tracker::Visits::DetailsController < Agent::BaseController

  # 详细
  def show
    authorize :'tracker/home', :index?
    respond_to do |format|
      format.html
      format.json {render json: Tracker::Visit.visits(page: params[:page])}
      # Tracker::Visit.visits(page: 2) 第二页
    end
  end

end
