require 'rails_helper'

RSpec.describe AccountHistory::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:account_history)
    flag, record = AccountHistory::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:account_history).slice(:name)
  #   flag, _ = AccountHistory::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:account_history)
  #   attrs = attributes_for(:account_history)
  #   flag, _ = AccountHistory::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
