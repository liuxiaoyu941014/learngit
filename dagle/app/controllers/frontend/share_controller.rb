class Frontend::ShareController < Frontend::BaseController
  # share 可接受：user/order/community/product/site
  # 实例：http://xxx.com/frontend/share/user/1
  def index
    begin
      if params[:class] == "sites"
        @share_obj = ::Site.find_by(id: params[:id])
      end
      if params[:class] == "communites"
        @share_obj = ::Community.find_by(id: params[:id])
      end
      if params[:class] == "users"
        @share_obj = current_user
      end
      if params[:class] == "articles"
        @share_obj = ::Article.find_by(id: params[:id])
      end
      # @share_obj = eval("::#{params[:class].capitalize}.find_by(id: #{params[:id]})")
    rescue
      @share_obj = @cms_site
    end
  end
end
