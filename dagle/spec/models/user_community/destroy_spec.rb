require 'rails_helper'

RSpec.describe UserCommunity::Create, type: :model do
  it do
    record = create(:user_community)
    true_of_false = UserCommunity::Destroy.(record)
    expect(true_of_false).to be_a(UserCommunity)
    expect(UserCommunity.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
