class SiteCatalog
  Update =
    lambda do |record_or_id, attributes, user: nil|
      record = record_or_id.is_a?(Catalog) ? record_or_id : SiteCatalog.find(record_or_id)
      if attributes["settings"].blank?
        attributes["settings"] = nil
      else
        attributes["settings"] = attributes["settings"].split(/[,，]/).map(&:strip)
      end
      record.assign_attributes attributes
      [record.save, record]
    end
end
