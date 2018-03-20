class Admin::Tracker::HomeController < Admin::BaseController

  # 汇总
  def index
    authorize :'tracker/home'
    respond_to do |format|
      format.html
      format.json {render json: {data: Tracker::Summary.report(current_user)}}
    end
  end

end
