require 'rails_helper'

RSpec.describe ImageItemTag::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:image_item_tag)
    flag, record = ImageItemTag::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:image_item_tag).slice(:name)
  #   flag, _ = ImageItemTag::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:image_item_tag)
  #   attrs = attributes_for(:image_item_tag)
  #   flag, _ = ImageItemTag::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
