require 'rails_helper'

RSpec.describe Permission::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:permission)
    flag, record = Permission::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:permission).slice(:name)
  #   flag, _ = Permission::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:permission)
  #   attrs = attributes_for(:permission)
  #   flag, _ = Permission::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
