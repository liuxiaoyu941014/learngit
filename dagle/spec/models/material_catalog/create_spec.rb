require 'rails_helper'

RSpec.describe MaterialCatalog::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:material_catalog)
    flag, record = MaterialCatalog::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:material_catalog).slice(:name)
  #   flag, _ = MaterialCatalog::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:material_catalog)
  #   attrs = attributes_for(:material_catalog)
  #   flag, _ = MaterialCatalog::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
