require 'rails_helper'

RSpec.describe Classorder::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:classorder)
    flag, record = Classorder::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:classorder).slice(:name)
  #   flag, _ = Classorder::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:classorder)
  #   attrs = attributes_for(:classorder)
  #   flag, _ = Classorder::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
