require 'rails_helper'

RSpec.describe Logistic::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:logistic)
    flag, record = Logistic::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:logistic).slice(:name)
  #   flag, _ = Logistic::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:logistic)
  #   attrs = attributes_for(:logistic)
  #   flag, _ = Logistic::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
