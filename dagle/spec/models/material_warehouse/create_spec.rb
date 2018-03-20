require 'rails_helper'

RSpec.describe MaterialWarehouse::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:material_warehouse)
    flag, record = MaterialWarehouse::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:material_warehouse).slice(:name)
  #   flag, _ = MaterialWarehouse::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:material_warehouse)
  #   attrs = attributes_for(:material_warehouse)
  #   flag, _ = MaterialWarehouse::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
