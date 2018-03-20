require 'rails_helper'

RSpec.describe MaterialManagement::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:material_management)
    flag, record = MaterialManagement::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:material_management).slice(:name)
  #   flag, _ = MaterialManagement::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:material_management)
  #   attrs = attributes_for(:material_management)
  #   flag, _ = MaterialManagement::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
