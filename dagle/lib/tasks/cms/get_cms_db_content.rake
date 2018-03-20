#encoding: utf-8
require 'fileutils'
#xj: run this script to generate cms data init in public/templetes/xxx/data_init.rb
namespace :cms do
  desc "to generate a initialized cms data from database to public/templetes/xxx/data_init.rb"
  task get_cms_db_content: :environment do
    puts ENV['TEMP']
    if ENV['TEMP'].blank?
      puts "请输入要保存的CMS模板目录名：bundle exec rake templete:get_db_seeds TEMP=xxx"
      exit
    end
    temp = ENV['TEMP']
    temp_dir = File.join(Rails.root, 'public/templetes/', temp)
    unless Dir.exist?(temp_dir)
      puts "找不到模板：#{temp_dir}"
      exit
    end

    @site = Cms::Site.find_by(template: temp)
    if @site.nil?
      puts "找不到site站点。"
      exit
    end

    db_file = File.open(File.join(temp_dir, 'data_init.rb'), 'w')
    #1. write account

    #2. write site
    db_file.write("\n@site = Cms::Site.create!(")
    db_file.write("\n  :name         => '#{@site.name || 'nil'}',")
    db_file.write("\n  :template     => '#{@site.template || 'nil'}',")
    db_file.write("\n  :domain       => '#{@site.domain || 'nil'}',")
    db_file.write("\n  :description  => '#{@site.description || 'nil'}',")
    db_file.write("\n  :is_published => #{@site.is_published || 'nil'}")
    db_file.write("\n)")
    #3. write channel
    @site.channels.find_each do |ch|
      db_file.write("\nCms::Channel.create!(")
      db_file.write("\n  :site_id      => @site.id,")
      db_file.write("\n  :parent_id    => #{ch.parent_id || 'nil'},")
      db_file.write("\n  :title        => '#{ch.title || 'nil'}',")
      db_file.write("\n  :short_title  => '#{ch.short_title || 'nil'}',")
      db_file.write("\n  :properties   => '#{ch.properties || 'nil'}',")
      db_file.write("\n  :tmp_index    => '#{ch.tmp_index || 'nil'}',")
      db_file.write("\n  :tmp_detail   => '#{ch.tmp_detail || 'nil'}',")
      db_file.write("\n  :keywords     => '#{ch.keywords || 'nil'}',")
      db_file.write("\n  :description  => '#{ch.description || 'nil'}',")
      db_file.write("\n  :image_path   => '#{ch.image_path || 'nil'}',")
      db_file.write("\n  :content      => '#{ch.content || 'nil'}'")
      db_file.write("\n)")
    end

    #4. write page
    @site.channels.each do |ch|
      ch.pages.find_each do |page|
        db_file.write("\nCms::Page.create!(")
        db_file.write("\n  :channel_id   => #{ch.id || 'nil'},")
        db_file.write("\n  :title        => '#{page.title || 'nil'}',")
        db_file.write("\n  :short_title  => '#{page.short_title || 'nil'}',")
        db_file.write("\n  :keywords     => '#{page.keywords || 'nil'}',")
        db_file.write("\n  :description  => '#{page.description || 'nil'}',")
        db_file.write("\n  :properties   => '#{page.properties || 'nil'}',")
        db_file.write("\n  :image_path   => '#{page.image_path || 'nil'}',")
        db_file.write("\n  :content      => '#{'nil'}'")
        db_file.write("\n)")
      end
    end

    #5. close
    db_file.close
  end
end
