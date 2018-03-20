# encoding: UTF-8
require 'roo'
require File.expand_path('../../config/environment', __FILE__)

class HandleFailedCommunityAndSite
  def run
    begin
      ImportFailedInformation.where(is_processed: 'n').limit(1000).each do |import_info|
        if import_info.origin_type == 'community'
          # migrate community
          migrate_community(import_info)
        elsif import_info.origin_type == 'site'
          # migrate site
          migrate_site(import_info)
        else
          raise '其他type'
        end
      end
    end while ImportFailedInformation.where(is_processed: 'n').limit(1).count > 0
  end

  def migrate_community(import_info)
    begin
      address_arr = []
      address_arr << import_info.province unless import_info.address_str.include?(import_info.province)
      address_arr << import_info.city unless import_info.address_str.include?(import_info.city)
      address_arr << import_info.district unless import_info.address_str.include?(import_info.district)
      address_arr << import_info.address_str
      # address_arr << import_info.name unless import_info.address_str.include?(import_info.name)

      c = Community.find_or_initialize_by(name: import_info.name, address_line: address_arr.join.strip)
      c.uid         = import_info.uid
      c.province    = import_info.province
      c.city        = import_info.city
      c.district    = import_info.district
      c.street      = import_info.street
      c.address_str = import_info.address_str
      c.telephone   = import_info.telephone
      c.lat         = import_info.lat
      c.lng         = import_info.lng
      c.tags        = import_info.tags
      c.image       = import_info.image
      c.keyword     = import_info.keyword
      c.save!
      import_info.is_processed = 'y'
    rescue
      import_info.is_processed = 'f'
    end
    import_info.save!
  end

  def migrate_site(import_info)
    begin
      city_arr = []
      city_arr << import_info.real_city
      city_arr << import_info.real_city unless import_info.real_city == import_info.real_city
      city_str = city_arr.join
      address_line_str  = [import_info.province, city_str, import_info.district, import_info.address_str.gsub(/(?:\(|（).*(?:\)|）)$/, '')].join.strip
      c = Site.find_or_initialize_by(title: import_info.name, address_line: address_line_str)

      c.is_published    = import_info.is_published
      c.province        = import_info.province
      c.real_city       = import_info.real_city
      c.city            = import_info.city
      c.district        = import_info.district
      c.catalog         = SiteCatalog.find_or_create_by_path([{name: import_info.big_cate},{name: import_info.small_cate}])
      c.business_area   = import_info.business_area
      c.phone           = import_info.telephone
      c.business_hours  = import_info.business_hours
      c.avg_price       = import_info.avg_price
      c.photos          = import_info.image
      c.parking         = import_info.parking
      c.recommendation  = import_info.recommendation
      c.good_summary    = import_info.good_summary
      c.bad_summary     = import_info.bad_summary
      c.properties      = import_info.tags
      c.lat             = import_info.lat
      c.lng             = import_info.lng

      c.save!
      import_info.is_processed = 'y'
    rescue
      import_info.is_processed = 'f'
    end
    import_info.save!
  end
end

if $0 == __FILE__
  HandleFailedCommunityAndSite.new.run
end
