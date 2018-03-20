class Cms::BaseController < Agent::BaseController
  helper Cms::ApplicationHelper
  before_action :set_current_cms_site

  def set_current_cms_site
    @cms_site = @site.cms_site
  end

end
