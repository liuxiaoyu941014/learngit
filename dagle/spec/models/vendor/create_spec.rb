require 'rails_helper'

RSpec.describe Vendor::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:vendor)
    flag, record = Vendor::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:vendor).slice(:name)
  #   flag, _ = Vendor::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:vendor)
  #   attrs = attributes_for(:vendor)
  #   flag, _ = Vendor::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
