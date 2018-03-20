class Site
  Update =
    lambda do |site_or_id, attributes, user: nil|
      site = site_or_id.is_a?(Site) ? site_or_id : Site.find(site_or_id)
      site.assign_attributes attributes
      flag = false
      begin
        flag = site.save
      rescue => Gnomon::Errors::GeocodingFailed
        flag = false
        site.errors.add :address_line, '不是一个正确的地址'
      end
      [flag, site]
    end
end