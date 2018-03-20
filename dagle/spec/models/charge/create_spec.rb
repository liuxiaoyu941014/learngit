require 'rails_helper'

RSpec.describe Charge::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:charge)
    flag, record = Charge::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:charge).slice(:name)
  #   flag, _ = Charge::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:charge)
  #   attrs = attributes_for(:charge)
  #   flag, _ = Charge::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
