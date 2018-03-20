require 'rails_helper'

RSpec.describe UserCommunity::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:user_community)
    flag, record = UserCommunity::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:user_community).slice(:name)
  #   flag, _ = UserCommunity::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:user_community)
  #   attrs = attributes_for(:user_community)
  #   flag, _ = UserCommunity::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
