require 'rails_helper'

RSpec.describe Course::Create, type: :model do
  it do
    record = create(:course)
    true_of_false = Course::Destroy.(record)
    expect(true_of_false).to be_a(Course)
    expect(Course.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
