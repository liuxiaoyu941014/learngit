require 'rails_helper'

RSpec.describe MaterialWarehouseItem::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:material_warehouse_item)
    flag, record = MaterialWarehouseItem::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:material_warehouse_item).slice(:name)
  #   flag, _ = MaterialWarehouseItem::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:material_warehouse_item)
  #   attrs = attributes_for(:material_warehouse_item)
  #   flag, _ = MaterialWarehouseItem::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
