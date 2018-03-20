class Admin::Tracker::Visits::StatisticsController < Admin::BaseController

  def show
    authorize :'tracker/home', :index?
    respond_to do |format|
      format.html
      format.json {render json: Tracker::VisitStatistic.page_statistic}
    end

  end

end
