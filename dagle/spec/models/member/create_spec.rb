require 'rails_helper'

RSpec.describe Member::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:member)
    flag, record = Member::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:member).slice(:name)
  #   flag, _ = Member::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:member)
  #   attrs = attributes_for(:member)
  #   flag, _ = Member::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
