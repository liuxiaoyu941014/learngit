class Frontend::ClassordersController < Frontend::BaseController
    before_action :ensure_login!
    acts_as_trackable user_id: :get_user_id, resource: :get_visit_resource, only: [:show]
    
    def index
        @class = Classorder.all
    end
    def new
        @class = Classorder.new
       
        @course = Course.find(params[:course_id])
    end
    def create
        @class = Classorder.new
       
     
        @class.course_id = params[:classorder][:course_id]
        @class.user_id = params[:classorder][:user_id]
        @class.name = params[:classorder][:name]
        @class.teacher_name = params[:classorder][:teacher_name]
        @class.weeknu = params[:classorder][:weeknu]
        @class.class_week = JSON.parse(params[:classorder][:class_week].gsub(/=>/,':'))   
        @class.class_day = JSON.parse(params[:classorder][:class_day].gsub(/=>/,':'))
        @class.class_time = JSON.parse(params[:classorder][:class_time].gsub(/=>/,':'))
        @class.class_place = JSON.parse(params[:classorder][:class_place].gsub(/=>/,':')) 
        if @class.save
           flash[:notice] = '选课成功'
           redirect_to frontend_classorders_path
        else
            render json: {errors:'本课程您已经选择过了,请选择其他课程'}
          end
        
    end
    def show
        @class = Classorder.find(params[:id])
    end
    def destroy
        @class = Classorder.find(params[:id])
        @class.destroy
        flash[:notice] = '撤销课程成功'
        redirect_to frontend_courses_path
    end
    def showtable
        @class = Classorder.all
    end
    private
    def ensure_login!
        redirect_to admin_sign_in_path unless current_user
    end
    def get_user_id
        current_user && current_user.id
    end
      
    def get_visit_resource
        @class
    end
end


