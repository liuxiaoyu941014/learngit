require 'rails_helper'

RSpec.describe Catalog::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:catalog)
    flag, record = Catalog::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:catalog).slice(:name)
  #   flag, _ = Catalog::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:catalog)
  #   attrs = attributes_for(:catalog)
  #   flag, _ = Catalog::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
