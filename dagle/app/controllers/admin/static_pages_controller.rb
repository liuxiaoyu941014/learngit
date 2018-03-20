class Admin::StaticPagesController < Admin::BaseController
  include HighVoltage::StaticPage
  skip_after_action :verify_authorized
  #before_filter :layout_for_page
  before_action :get_menus

  private

  def layout_for_page
    case params[:id]
    when 'home'
      'admin'
    else
      'admin'
    end
  end

  def get_menus
    @menus = {}
    HighVoltage.page_ids.map{|s| s.split('/')}.each do |s|
      if s.size == 1
        @menus[s[0]] = s[0]
      else
        if @menus.has_key?(s[0])
          @menus[s[0]] << s[1]
        else
          @menus[s[0]] = [s[1]]
        end
      end
    end
  end
end
