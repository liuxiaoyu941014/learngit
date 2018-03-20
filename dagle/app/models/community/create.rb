class Community
  Create =
    lambda do |attributes, user: nil|
      record = Community.new(attributes)
      flag = false
      begin
        flag = record.save
      rescue => Gnomon::Errors::GeocodingFailed
        flag = false
        record.errors.add :address_line, '不是一个正确的地址'
      end
      [flag, record]
    end
end
