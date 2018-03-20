require 'rails_helper'

RSpec.describe Diymenu::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:diymenu)
    flag, record = Diymenu::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:diymenu).slice(:name)
  #   flag, _ = Diymenu::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:diymenu)
  #   attrs = attributes_for(:diymenu)
  #   flag, _ = Diymenu::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
