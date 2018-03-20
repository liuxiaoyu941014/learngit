require 'rails_helper'

RSpec.describe Notification::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:notification)
    flag, record = Notification::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:notification).slice(:name)
  #   flag, _ = Notification::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:notification)
  #   attrs = attributes_for(:notification)
  #   flag, _ = Notification::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
