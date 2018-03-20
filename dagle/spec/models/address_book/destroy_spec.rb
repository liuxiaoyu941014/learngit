require 'rails_helper'

RSpec.describe AddressBook::Create, type: :model do
  it do
    record = create(:address_book)
    true_of_false = AddressBook::Destroy.(record)
    expect(true_of_false).to be_a(AddressBook)
    expect(AddressBook.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
