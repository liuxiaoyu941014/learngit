require 'rails_helper'

RSpec.describe AddressBook::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:address_book)
    flag, record = AddressBook::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:address_book).slice(:name)
  #   flag, _ = AddressBook::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:address_book)
  #   attrs = attributes_for(:address_book)
  #   flag, _ = AddressBook::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
