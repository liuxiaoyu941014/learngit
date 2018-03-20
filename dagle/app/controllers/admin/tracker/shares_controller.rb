class Admin::Tracker::SharesController < Admin::BaseController

  def index
    authorize :'tracker/home', :index?
    respond_to do |format|
      format.html
      format.json {render json: {data: Tracker::Share.records(current_user, params[:page])}}
    end
  end

  def chart_data
    authorize :'tracker/home', :index?
    render json: {chart_data: Tracker::Share.chart_data(current_user, params[:date])}
  end
end
