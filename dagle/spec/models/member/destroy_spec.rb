require 'rails_helper'

RSpec.describe Member::Create, type: :model do
  it do
    record = create(:member)
    true_of_false = Member::Destroy.(record)
    expect(true_of_false).to be_a(Member)
    expect(Member.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
