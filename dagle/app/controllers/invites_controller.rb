class InvitesController < ApplicationController
  layout false
  def show
    @resource = SalesDistribution::Resource.find_by(code: params[:code])
    @user = @resource.user
    unless @resource && @resource.type_name == '用户注册'
      head 404
      return
    end
  end
end
