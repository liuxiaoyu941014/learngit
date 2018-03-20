require 'rails_helper'

RSpec.describe Chat::Room::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:room)
    flag, record = Chat::Room::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:room).slice(:name)
  #   flag, _ = Chat::Room::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:room)
  #   attrs = attributes_for(:room)
  #   flag, _ = Chat::Room::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
