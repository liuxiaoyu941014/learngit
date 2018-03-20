require 'rails_helper'

RSpec.describe MemberCatalog::Create, type: :model do
  it do
    record = create(:member_catalog)
    true_of_false = MemberCatalog::Destroy.(record)
    expect(true_of_false).to be_a(MemberCatalog)
    expect(MemberCatalog.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
