require 'rails_helper'

RSpec.describe MaterialManagementDetail::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:material_management_detail)
    flag, record = MaterialManagementDetail::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:material_management_detail).slice(:name)
  #   flag, _ = MaterialManagementDetail::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:material_management_detail)
  #   attrs = attributes_for(:material_management_detail)
  #   flag, _ = MaterialManagementDetail::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
