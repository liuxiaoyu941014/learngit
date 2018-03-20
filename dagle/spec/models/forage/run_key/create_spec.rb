require 'rails_helper'

RSpec.describe Forage::RunKey::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:run_key)
    flag, record = Forage::RunKey::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:run_key).slice(:name)
  #   flag, _ = Forage::RunKey::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:run_key)
  #   attrs = attributes_for(:run_key)
  #   flag, _ = Forage::RunKey::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
