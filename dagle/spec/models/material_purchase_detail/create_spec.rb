require 'rails_helper'

RSpec.describe MaterialPurchaseDetail::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:material_purchase_detail)
    flag, record = MaterialPurchaseDetail::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:material_purchase_detail).slice(:name)
  #   flag, _ = MaterialPurchaseDetail::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:material_purchase_detail)
  #   attrs = attributes_for(:material_purchase_detail)
  #   flag, _ = MaterialPurchaseDetail::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
