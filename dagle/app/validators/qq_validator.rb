class QqValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A\d{4,}\z/i
      record.errors[attribute] << (options[:message] || "is not qq")
    end
  end
end
