require 'rails_helper'

RSpec.describe Refund::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:refund)
    flag, record = Refund::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:refund).slice(:name)
  #   flag, _ = Refund::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:refund)
  #   attrs = attributes_for(:refund)
  #   flag, _ = Refund::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
