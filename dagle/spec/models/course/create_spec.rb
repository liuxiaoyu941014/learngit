require 'rails_helper'

RSpec.describe Course::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:course)
    flag, record = Course::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:course).slice(:name)
  #   flag, _ = Course::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:course)
  #   attrs = attributes_for(:course)
  #   flag, _ = Course::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
