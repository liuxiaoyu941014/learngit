require 'rails_helper'

RSpec.describe <%= class_name %>::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:<%= file_name %>)
    flag, record = <%= class_name %>::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:<%= file_name %>).slice(:name)
  #   flag, _ = <%= class_name %>::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:<%= file_name %>)
  #   attrs = attributes_for(:<%= file_name %>)
  #   flag, _ = <%= class_name %>::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
