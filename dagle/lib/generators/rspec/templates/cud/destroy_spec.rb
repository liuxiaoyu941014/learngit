require 'rails_helper'

RSpec.describe <%= class_name %>::Create, type: :model do
  it do
    record = create(:<%= file_name %>)
    true_of_false = <%= class_name %>::Destroy.(record)
    expect(true_of_false).to be_a(<%= class_name %>)
    expect(<%= class_name %>.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
