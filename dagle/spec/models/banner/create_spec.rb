require 'rails_helper'

RSpec.describe Banner::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:banner)
    flag, record = Banner::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:banner).slice(:name)
  #   flag, _ = Banner::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:banner)
  #   attrs = attributes_for(:banner)
  #   flag, _ = Banner::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
