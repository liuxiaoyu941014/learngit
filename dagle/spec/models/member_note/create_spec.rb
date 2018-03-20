require 'rails_helper'

RSpec.describe MemberNote::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:member_note)
    flag, record = MemberNote::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:member_note).slice(:name)
  #   flag, _ = MemberNote::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:member_note)
  #   attrs = attributes_for(:member_note)
  #   flag, _ = MemberNote::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
