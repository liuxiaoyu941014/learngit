class Frontend::CoursesController < Frontend::BaseController
  #前台首页
  def index
    @news_channel = @cms_site.channels.find_by(short_title: 'index')
    
    @course = Course.all
  end
  def show 
    @course = Course.find(params[:id])
    
  end
  
end

