# encoding: UTF-8
require File.expand_path('../../config/environment', __FILE__)

class ForageWgtong
  def run
    forage_hdb
    forage_gov_zixun
  end

  def forage_gov_zixun
    source_name = '国家数字文化网'
    source = Forage::Source.where(name: source_name).first
    source_url = source.url
    source.run_keys.where(is_processed: 'f').update_all(is_processed: 'n')
    current_run_key = source.run_keys.order("date asc").last

    # simple
    gov_zixun_simple(current_run_key) if current_run_key.is_processed == 'n'
    raise 'run key 失败' if current_run_key.is_processed == 'f'
    # detail
    gov_zixun_detail(current_run_key)
  end

  def gov_zixun_detail(current_run_key)
    puts "extract #{current_run_key.source.name} detail"
    headless = Headless.new
    headless.start
    profile = Selenium::WebDriver::Firefox::Profile.new
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 300
    driver = Selenium::WebDriver.for :firefox, http_client: client

    current_run_key.simples.where(is_processed: 'f').update_all(is_processed: 'n')
    current_run_key.simples.where(is_processed: 'n').each do |simple|
      begin
        detail_page = driver.navigate.to simple.url
        sleep(2)
        detail_doc = Nokogiri::HTML(driver.page_source)
        detail_title = detail_doc.xpath("//div[@class='mod1']/h1").text
        detail_description = detail_doc.xpath("//div[@class='mod1']/div[@class='info']").text
        detail_content = detail_doc.xpath("//div[@class='mod1']/div[@class='read']/div[@class='TRS_Editor']")
        detail_content_style =  detail_content.first.css('style').to_html
        detail_content = detail_content.to_html.gsub(detail_content_style, '')

        forage_detail = simple.details.find_or_initialize_by(url: simple.url)
        forage_detail.title = detail_title
        forage_detail.description = detail_description
        forage_detail.content = detail_content
        forage_detail.save
        simple.is_processed = 'y'
      rescue => e
        puts e.message
        simple.is_processed = 'f'
      end
      simple.save!
    end

    driver.quit
    headless.destroy
  end

  def gov_zixun_simple(current_run_key)
    puts "extract #{current_run_key.source.name} simple"
    headless = Headless.new
    headless.start
    profile = Selenium::WebDriver::Firefox::Profile.new
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 300
    driver = Selenium::WebDriver.for :firefox, http_client: client

    main_url = current_run_key.source.url

    begin
      driver.navigate.to current_run_key.source.url
      sleep(2)
      main_doc = Nokogiri::HTML(driver.page_source)
      run_key_str = main_doc.xpath("//div[@class='mod1']//div[@class='tit']").first.text

      loop do
        content_doc_arr = main_doc.xpath("//div[@class='mod1']/div[@class='con']/ul/li")
        content_doc_arr.each do |simple_doc|
          # simple
          simple_title = simple_doc.css('a').text
          simple_url = main_url + simple_doc.css('a').first['href'].gsub(/^\.\//, '')
          simple_date = simple_doc.css('span').text
          forage_simple = current_run_key.simples.find_or_initialize_by(url: simple_url)
          forage_simple.title = simple_title
          forage_simple.save
        end

        next_page = main_doc.xpath("//div[@id='displaypagenum']/a[contains(text(), '下一页')]")
        if next_page.blank?
          break
        else
          next_page_url = main_url + next_page.first['href']
          driver.navigate.to next_page_url
          sleep(2)
          main_doc = Nokogiri::HTML(driver.page_source)
        end
      end
      current_run_key.update_attributes(is_processed: 'y')
    rescue => e
      current_run_key.update_attributes(is_processed: 'f')
      puts e.message
    end

    driver.quit
    headless.destroy
  end

  def forage_hdb
    source_name = '互动吧'
    source = Forage::Source.where(name: source_name).first
    source_url = source.url
    source.run_keys.where(is_processed: 'f').update_all(is_processed: 'n')
    current_run_key = source.run_keys.order("date asc").last
    # simple
    hdb_simple(current_run_key) if current_run_key && current_run_key.is_processed == 'n'
    # detail
    hdb_detail(current_run_key) if current_run_key
  end

  def hdb_detail(current_run_key)
    headless = Headless.new
    headless.start
    profile = Selenium::WebDriver::Firefox::Profile.new
    client = Selenium::WebDriver::Remote::Http::Default.new
    client.read_timeout = 300
    driver = Selenium::WebDriver.for :firefox, http_client: client

    current_run_key.simples.where(is_processed: 'f').update_all(is_processed: 'n')
    current_run_key.simples.where(is_processed: 'n').each do |simple|
      begin
        driver.navigate.to simple.url
        sleep(3)
        detail_page_doc = Nokogiri::HTML(driver.page_source)
        detail_title = detail_page_doc.xpath("//div[@class='detail_title']").text.strip
        address      = detail_page_doc.xpath("//div[@class='detail_Attr']").text.gsub(/.*地点：/, '').strip
        image_url    = detail_page_doc.xpath("//div[@class='content-body_head_l']/img").first["src"] unless detail_page_doc.xpath("//div[@class='content-body_head_l']/img").blank?
        content      = detail_page_doc.xpath("//div[@id='dt_content']").first.try{to_html}

        times_arr = []
        detail_page_doc.xpath("//div[@class='detail_Time_t']").text.split(/\s*\n+\s*/).each do |time|
          next if time =~ /(：$|list\.)/ || time.strip.blank?
          times_arr << time
        end
        times = times_arr.join(', ')

        tickets = []
        detail_page_doc.xpath("//ul[@class='ticket tc_c_feiLi']/li").each do |ticket|
          tickets << ticket.text.strip.gsub(/\s+/, '-')
        end
        price = tickets.join(', ')

        forage_detail = simple.details.find_or_initialize_by(url: simple.url)
        forage_detail.title = detail_title
        forage_detail.time = times
        forage_detail.address_line1 = address
        forage_detail.price = price
        forage_detail.image = image_url
        forage_detail.content = content
        forage_detail.save
        simple.is_processed = 'y'
      rescue => e
        puts e.message
        simple.is_processed = 'f'
      end
      simple.save!
    end
    driver.quit
    headless.destroy
  end

  def hdb_simple(current_run_key)
    headless = Headless.new
    headless.start
    profile = Selenium::WebDriver::Firefox::Profile.new
    driver = Selenium::WebDriver.for :firefox
    begin
      driver.navigate.to current_run_key.source.url
      sleep(2)
      main_doc = Nokogiri::HTML(driver.page_source)
      i = 0

      loop do
        i += 1
        content_doc_arr = main_doc.xpath("//li[@class='find_main_li img find']")
        content_doc_arr.each do |simple_doc|
          # simple
          simple_url = simple_doc.css('h3/a').first["href"]
          simple_title = simple_doc.css('h3/a').text.strip
          forage_simple = current_run_key.simples.find_or_initialize_by(url: simple_url)
          forage_simple.title = simple_title
          forage_simple.save
        end

        next_page = main_doc.xpath("//div[@class='join_feny']/a[contains(text(), '下一页　')]")
        if next_page.blank? || i > 200
          break
        else
          next_page_url = next_page.first['href']
          driver.navigate.to next_page_url
          sleep(2)
          main_doc = Nokogiri::HTML(driver.page_source)
        end
      end
      current_run_key.update_attributes(is_processed: 'y')
    rescue => e
      current_run_key.update_attributes(is_processed: 'f')
      raise e.message
    end

    driver.quit
    headless.destroy
  end

end

if $0 == __FILE__
  ForageWgtong.new.run
end
