require 'rails_helper'

RSpec.describe ImageItem::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:image_item)
    flag, record = ImageItem::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:image_item).slice(:name)
  #   flag, _ = ImageItem::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:image_item)
  #   attrs = attributes_for(:image_item)
  #   flag, _ = ImageItem::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
