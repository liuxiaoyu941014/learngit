class MobilePhoneValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A1\d{10}\z/i
      record.errors[attribute] << (options[:message] || "不是一个正确的手机号")
    end
  end
end
