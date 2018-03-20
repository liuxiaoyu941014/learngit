class Admin::Tracker::TwoSharesController < Admin::BaseController

  def index
    authorize :'tracker/home', :index?
    respond_to do |format|
      format.html
      format.json {render json: {data: Tracker::Share.find_child_two_records(params[:share_id], current_user, params[:page])}}
    end
  end

end
