class AddressBook
  Create =
    lambda do |attributes, user: nil|
      record = AddressBook.new(attributes)
      [record.save, record]
    end
end
