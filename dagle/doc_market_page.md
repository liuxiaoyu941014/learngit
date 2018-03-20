# 什么是营销页

营销页就是通过模板实现的H5页面，用于帮助用户快速制作基于微信的活动、促销、报名、节日祝福等宣传页面。
营销页的制作顺序： 在admin端添加好营销页模板；在agent通过选择模板进行制作；通过agent端生成独立的分销页面进行传播。

# 如何创建一个营销页

  1. 将营销页模板复制到public/templetes/market目录下，站点的结构大致如下：
  <pre>
    public/templetes
            |templete_name
                |assets（存放css/js/font）
                |images (存放图片)
                |index.html (原始静态页面)
                |temp_index.html （修改后的index）
    </pre>

    2. 添加模板 market_template
    <p>在admin端，创建一个market_template, 其中两个属性来源：
    <p>html_source: 将静态页面index.html复制一份到【temp_index.html.erb】中，考虑到需要动态实现的元素，用动态方法写出来</p>
    <p>form_source: 对应html_source中的动态元素，在创建market_template的时候会自动生成</p>

    3. 创建营销页

      在agent端，两步完成营销页创建： 选择模板；完成动态内容表单填值。

  涉及文件：

      app/models/market_catalog.rb
      app/models/market_tempalte.rb
      app/models/market_page.rb

      app/controllers/admin/market_catalog.rb
      app/controllers/admin/market_tempalte.rb
      app/controllers/admin/market_page.rb

      app/controllers/agent/market_page.rb

## html_source 源文件实例

      <html lang="zh-CN">
        <head>
          <meta charset="utf-8"/>
          <title><%= @market_page.name %></title>
          <meta content="<%= @market_page.description %>" name="description"/>
        </head>
        <body style="text-align: center;">
          <div style="margin: 0 auto; width:640px;">
            <h2><%= @market_page.value_for("title", title: "文章标题", typo: "string", default: "文章标题") %></h2><hr/>
            <div style="text-align:left;"><%= simple_format @market_page.value_for("content", title: "正文", typo: "text", default: "文章内容") %></div>
            <% @market_page.image_items.each do |img| %>
             <%= image_tag img.image_url, style: "width:100%;" %>
            <% end %>
          </div>
        </body>
      </html>
