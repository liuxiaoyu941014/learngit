class Diymenu
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Diymenu) ? record_or_id : Diymenu.find(record_or_id)
      record.destroy
    end
end
