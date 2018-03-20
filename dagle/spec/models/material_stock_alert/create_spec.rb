require 'rails_helper'

RSpec.describe MaterialStockAlert::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:material_stock_alert)
    flag, record = MaterialStockAlert::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:material_stock_alert).slice(:name)
  #   flag, _ = MaterialStockAlert::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:material_stock_alert)
  #   attrs = attributes_for(:material_stock_alert)
  #   flag, _ = MaterialStockAlert::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
