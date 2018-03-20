require 'rails_helper'

RSpec.describe Material::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:material)
    flag, record = Material::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:material).slice(:name)
  #   flag, _ = Material::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:material)
  #   attrs = attributes_for(:material)
  #   flag, _ = Material::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
