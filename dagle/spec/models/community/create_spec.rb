require 'rails_helper'

RSpec.describe Community::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:community)
    flag, record = Community::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:community).slice(:name)
  #   flag, _ = Community::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:community)
  #   attrs = attributes_for(:community)
  #   flag, _ = Community::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
