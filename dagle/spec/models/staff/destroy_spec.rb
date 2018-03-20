require 'rails_helper'

RSpec.describe Staff::Create, type: :model do
  it do
    record = create(:staff)
    true_of_false = Staff::Destroy.(record)
    expect(true_of_false).to be_a(Staff)
    expect(Staff.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
