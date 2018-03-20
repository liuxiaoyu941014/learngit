require 'rails_helper'

RSpec.describe Community::Create, type: :model do
  it do
    record = create(:community)
    true_of_false = Community::Destroy.(record)
    expect(true_of_false).to be_a(Community)
    expect(Community.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
