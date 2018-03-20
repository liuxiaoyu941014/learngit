require 'rails_helper'

RSpec.describe Account::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:account)
    flag, record = Account::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:account).slice(:name)
  #   flag, _ = Account::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:account)
  #   attrs = attributes_for(:account)
  #   flag, _ = Account::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
