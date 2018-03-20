class Frontend::HomeController < Frontend::BaseController
  #前台首页
  def index
    @news_channel = @cms_site.channels.find_by(short_title: 'news')
    @product = @site.products
  end
end
