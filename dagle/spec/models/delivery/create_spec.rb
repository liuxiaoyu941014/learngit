require 'rails_helper'

RSpec.describe Delivery::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:delivery)
    flag, record = Delivery::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:delivery).slice(:name)
  #   flag, _ = Delivery::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:delivery)
  #   attrs = attributes_for(:delivery)
  #   flag, _ = Delivery::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
