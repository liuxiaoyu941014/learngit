require 'rails_helper'

RSpec.describe Forage::Simple::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:simple)
    flag, record = Forage::Simple::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:simple).slice(:name)
  #   flag, _ = Forage::Simple::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:simple)
  #   attrs = attributes_for(:simple)
  #   flag, _ = Forage::Simple::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
