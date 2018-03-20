class Agent::Tracker::Visits::StatisticsController < Agent::BaseController

  def show
    authorize :'tracker/home', :index?
    respond_to do |format|
      format.html
      format.json {render json: Tracker::VisitStatistic.page_statistic}
    end

  end

end
