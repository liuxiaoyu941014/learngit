require 'rails_helper'

RSpec.describe Keystore::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:keystore)
    flag, record = Keystore::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:keystore).slice(:name)
  #   flag, _ = Keystore::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:keystore)
  #   attrs = attributes_for(:keystore)
  #   flag, _ = Keystore::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
