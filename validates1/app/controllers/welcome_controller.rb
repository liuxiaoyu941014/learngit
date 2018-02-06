class WelcomeController < ApplicationController
  # devise会默认创建一个帮助方法：
  # before_action :authenticate_user!
  # user_signed_in? //判断用户是否登录
  # current_user //获取当前登录用户
  # user_session //可以访问对应的session
  before_action :authenticate_user!, :only => [:index, :new]  #在控制器中，设置访问之前需要先登录
  def index
  end
end
