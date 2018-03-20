require 'rails_helper'

RSpec.describe Staff::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:staff)
    flag, record = Staff::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:staff).slice(:name)
  #   flag, _ = Staff::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:staff)
  #   attrs = attributes_for(:staff)
  #   flag, _ = Staff::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
