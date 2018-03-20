require 'rails_helper'

RSpec.describe MemberNote::Create, type: :model do
  it do
    record = create(:member_note)
    true_of_false = MemberNote::Destroy.(record)
    expect(true_of_false).to be_a(MemberNote)
    expect(MemberNote.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
