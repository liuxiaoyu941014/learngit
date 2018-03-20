class AppSetting
  Create =
    lambda do |attributes, user: nil|
      record = AppSetting.new(attributes)
      [record.save, record]
    end
end
