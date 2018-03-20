class Community
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Community) ? record_or_id : Community.find(record_or_id)
      record.assign_attributes attributes
      begin
        flag = record.save
      rescue => Gnomon::Errors::GeocodingFailed
        flag = false
        record.errors.add :address_line, '不是一个正确的地址'
      end
      [record.save, record]
    end
end
