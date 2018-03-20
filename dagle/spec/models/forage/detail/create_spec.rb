require 'rails_helper'

RSpec.describe Forage::Detail::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:detail)
    flag, record = Forage::Detail::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:detail).slice(:name)
  #   flag, _ = Forage::Detail::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:detail)
  #   attrs = attributes_for(:detail)
  #   flag, _ = Forage::Detail::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
