require 'rails_helper'

RSpec.describe MarketTemplate::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:market_template)
    flag, record = MarketTemplate::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:market_template).slice(:name)
  #   flag, _ = MarketTemplate::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:market_template)
  #   attrs = attributes_for(:market_template)
  #   flag, _ = MarketTemplate::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
