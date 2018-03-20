class Frontend::BaseController < ApplicationController
  before_action :set_view_path
  layout 'layouts/frontend'
  helper Cms::ApplicationHelper
  include Cms::ApplicationHelper
  before_action :load_cms_site

  private
  def load_cms_site
    @cms_site = Cms::Site.where("domain = ? OR root_domain = ?", request.subdomain, request.domain).first
    @cms_site ||= Cms::Site.first
    @site = @cms_site.site
  end

  #不同的项目，Views定位到不同的路径
  def set_view_path
    prepend_view_path(Rails.root.join('app', 'views_frontend', Settings.project))
  end
end
