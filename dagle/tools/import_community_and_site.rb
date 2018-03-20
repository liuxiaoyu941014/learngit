# encoding: UTF-8
require 'roo'
require File.expand_path('../../config/environment', __FILE__)

class ImportCommunityAndSite
  def run
    community_files = []
    site_files = []
    Dir.foreach("../public/import_data") do |filename|
      if filename =~ /community_file_\d+/
        community_files << filename
      elsif filename =~ /site_file_\d+/
        site_files << filename
      end
    end
    # import community
    import_community(community_files)
    # import site
    import_site(site_files)
  end

  def import_community(community_files)
    community_files.each do |file|
      file_path= "../public/import_data/" + file
      puts "import community: " + file
      worksheet = nil
      worksheet = Roo::Excelx.new(file_path)
      2.upto worksheet.last_row do |index|
        puts index if index % 10000 == 0
        import_data = ImportInformation.find_or_initialize_by(origin_type: 'community', file_name: file, line: index)
        import_data.name = worksheet.row(index)[1]
        import_data.uid         = worksheet.row(index)[0]
        import_data.province    = worksheet.row(index)[2]
        import_data.city        = worksheet.row(index)[3]
        import_data.district    = worksheet.row(index)[4]
        import_data.street      = worksheet.row(index)[5]
        import_data.address_str = worksheet.row(index)[6]
        import_data.telephone   = worksheet.row(index)[7]
        import_data.lat         = worksheet.row(index)[8]
        import_data.lng         = worksheet.row(index)[9]
        import_data.tags        = worksheet.row(index)[10]
        import_data.image       = worksheet.row(index)[11]
        import_data.keyword     = worksheet.row(index)[12]
        import_data.is_parsed   = 'n'
        import_data.save!
      end
    end
  end

  def import_site(site_files)
    site_files.each do |file|
      file_path= "../public/import_data/" + file
      puts "import site: " + file
      site_worksheet = nil
      site_worksheet = Roo::Excelx.new(file_path)
      head = site_worksheet.row(1)[0].split(/\"\s*,\s*\"/).map{|s| s.gsub(/^\"|\"$/, '').strip}
      2.upto site_worksheet.last_row do |index|
        puts index if index % 10000 == 0
        info_arr = site_worksheet.row(index)[0].split(/\"\s*,\s*\"/).map{|s| s.gsub(/^\"|\"$/, '').strip}
        import_data = ImportInformation.find_or_initialize_by(origin_type: 'site', file_name: file, line: index)
        import_data.name        = info_arr[head.find_index('name')]
        import_data.address_str = info_arr[head.find_index('address')]
        import_data.big_cate    = info_arr[head.find_index('big_cate')]
        import_data.small_cate  = info_arr[head.find_index('small_cate')]
        import_data.is_published    = !(info_arr[head.find_index('is_closed')].downcase == 'true' ? true : false )
        import_data.province        = info_arr[head.find_index('province')]
        import_data.real_city       = info_arr[head.find_index('real_city')]
        import_data.city            = info_arr[head.find_index('city')]
        import_data.district        = info_arr[head.find_index('area')]
        import_data.business_area   = info_arr[head.find_index('business_area')]
        import_data.telephone       = info_arr[head.find_index('phone')]
        import_data.business_hours  = info_arr[head.find_index('hours')]
        import_data.avg_price       = info_arr[head.find_index('avg_price')]
        import_data.image           = info_arr[head.find_index('photos')]
        import_data.parking         = info_arr[head.find_index('parking')]
        import_data.recommendation  = info_arr[head.find_index('recommended_products')]
        import_data.good_summary    = info_arr[head.find_index('good_remarks')]
        import_data.bad_summary     = info_arr[head.find_index('bad_remarks')]
        import_data.tags            = info_arr[head.find_index('tags')]
        import_data.lat             = info_arr[head.find_index('latitude')]
        import_data.lng             = info_arr[head.find_index('longitude')]
        import_data.is_parsed       = 'n'
        import_data.save!
      end
    end
  end
end

if $0 == __FILE__
  ImportCommunityAndSite.new.run
end
