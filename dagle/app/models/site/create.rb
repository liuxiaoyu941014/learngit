class Site
  Create =
    lambda do |attributes, user: nil|
      site = Site.new(attributes)
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