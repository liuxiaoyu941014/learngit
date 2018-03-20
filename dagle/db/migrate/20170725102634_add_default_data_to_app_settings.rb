class AddDefaultDataToAppSettings < ActiveRecord::Migration[5.0]
  def change
    AppSetting.create(
      name: '默认配置',
      key_word: 'default',
      site_share_url_pattern: "http://www.imolin.cn/desktop/share/sites/:id",
      product_share_url_pattern: "http://www.imolin.cn/desktop/share/products/:id",
      system_rooms: "['小区广场', '业委会', '物业圈', '吐槽圈', '互助圈', '亲子圈', '敬老圈', '宠物圈', '棋艺圈']",
      service_banners: "---\r\n- src: http://ot7w18mwp.bkt.clouddn.com/ban-3.jpg\r\n  url:\r\n- src: http://ot7w18mwp.bkt.clouddn.com/ban-2.jpg\r\n  url:\r\n- src: http://ot7w18mwp.bkt.clouddn.com/ban-1.jpg\r\n  url:",
      main_banners: "---\r\n- src: http://ot7w18mwp.bkt.clouddn.com/ban-3.jpg\r\n  url:\r\n- src: http://ot7w18mwp.bkt.clouddn.com/ban-2.jpg\r\n  url:\r\n- src: http://ot7w18mwp.bkt.clouddn.com/ban-1.jpg\r\n  url:",
      app_version_message: "---\r\nversion_number: 2.1.3\r\ndownload_url: http://...."
    )
  end
end
