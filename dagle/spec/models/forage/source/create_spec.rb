require 'rails_helper'

RSpec.describe Forage::Source::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:source)
    flag, record = Forage::Source::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:source).slice(:name)
  #   flag, _ = Forage::Source::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:source)
  #   attrs = attributes_for(:source)
  #   flag, _ = Forage::Source::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
