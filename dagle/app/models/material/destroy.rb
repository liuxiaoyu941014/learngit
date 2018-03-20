class Material
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(Material) ? record_or_id : Material.find(record_or_id)
      record.destroy
    end
end
