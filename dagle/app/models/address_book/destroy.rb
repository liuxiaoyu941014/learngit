class AddressBook
  Destroy =
    lambda do |record_or_id, user: nil|
      record = record_or_id.is_a?(AddressBook) ? record_or_id : AddressBook.find(record_or_id)
      record.destroy
    end
end
