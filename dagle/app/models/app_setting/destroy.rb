class AppSetting
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(AppSetting) ? record_or_id : AppSetting.find(record_or_id)
      record.destroy
    end
end
