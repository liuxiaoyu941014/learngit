require 'rails_helper'

RSpec.describe <%= class_name %>::Create, type: :model do

  # it 'for name' do
  #   record = create(:<%= file_name %>)
  #   flag, new_record = <%= class_name%>::Update.(record, name: 'new name')
  #   expect(flag).to eq(true)
  #   expect(new_record.name).to eq(new_record.name)
  # end

  # it 'with existing record' do
  #   record1 = create(:<%= file_name %>)
  #   record2 = create(:<%= file_name %>2)
  #   attrs = attributes_for(:<%= file_name %>2)
  #   flag, _ = <%= class_name %>::Update.(record1, attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
