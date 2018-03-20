require 'rails_helper'

RSpec.describe AccountHistory::Create, type: :model do
  it do
    record = create(:account_history)
    true_of_false = AccountHistory::Destroy.(record)
    expect(true_of_false).to be_a(AccountHistory)
    expect(AccountHistory.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
