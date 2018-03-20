module Cms::ApplicationHelper
  def meta_title(page_title)
    content_for(:title){ page_title}
  end
  def meta_keywords(meta_keywords)
    content_for(:meta_keywords){ meta_keywords}
  end
  def meta_description(meta_description)
    content_for(:meta_description){ meta_description}
  end
  def cms_content(item_content)
    content_for(:content){ raw item_content }
  end

  ################################################
  #############helper for cms frontend ####################
  #
  def get_date(date)
    date.strftime("%Y-%m-%d")
  end

  #use for Frontpage: get production frontpage path
  # get_cms_url(obj)
  # get_cms_url('short_title')
  def get_cms_url(obj, params = {})
    prefix = cms_frontend_root_url(params)
    case obj
    when Cms::Page
      prefix.concat("#{obj.channel.short_title}/#{obj.id}")
    when Cms::Channel
      prefix.concat("#{obj.short_title}")
    when String
      prefix.concat("#{obj}")
    else
      prefix
    end
  end

  #前台获得下拉列表菜单
  #默认调用方法：get_menu(@cms_site, 'product')
  #level: 显示的层级深度，默认为2级；如果要显示3级，则调用：get_menu(@cms_site, 'product', 3)
  def get_menu(cms_site, channel_title_or_short_title, opt={})
    level = opt[:level].to_i || 2
    parent_channel = cms_site.channels.find_by(short_title: channel_title_or_short_title)
    parent_channel ||= cms_site.channels.find_by(title: channel_title_or_short_title)
    return [] if parent_channel.nil?
    if parent_channel.children.any? && (level = level - 1) >= 0
      str_arr = []
      str_arr << %{<li class="dropdown">}
      if mobile_device?
      str_arr << %{<a class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false"> #{parent_channel.title} <b class="caret"></b></a>}
      else
        str_arr << %{<a class="dropdown-toggle"  href="#{get_cms_url(parent_channel)}"> #{parent_channel.title} <b class="caret"></b></a>}
      end
      str_arr << %{<ul class="dropdown-menu">}
      parent_channel.children.each do |ch|
        str_arr << get_menu(cms_site, ch.short_title, level: level - 1)
      end
      str_arr << %{</ul></li>}
      str_arr.join("\n").html_safe
    else
      %{<li><a class="#{opt[:css]}" href="#{get_cms_url(parent_channel)}">#{parent_channel.title}</a></li>}.html_safe
    end
  end

  #把ckeditor内容里面的图片地址全部查询出来，包括宽高
  #<img alt="" src="/ckeditor/pictures/148/original.jpg" style="width: 640px; height: 427px;" />
  #=> {src: "/ckeditor/pictures/148/original.jpg", alt: 'hello', width: "640", height: "427"}
  def get_images_from_content(content)
    photos = []
    return photos if content.blank?
    Nokogiri::HTML(content).search("img").each do |img|
      next if img['src'].blank?
      photo = {}
      photo['src'] = img['src']
      photo['alt'] = img['alt']
      photo['width'] = $1.to_i if img['style'] =~ /width: (\d+)/i
      photo['height'] = $1.to_i if img['style'] =~ /height: (\d+)/i
      photos << photo
    end
    return photos
  end

end
