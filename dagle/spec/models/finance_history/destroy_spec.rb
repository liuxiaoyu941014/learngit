require 'rails_helper'

RSpec.describe FinanceHistory::Create, type: :model do
  it do
    record = create(:finance_history)
    true_of_false = FinanceHistory::Destroy.(record)
    expect(true_of_false).to be_a(FinanceHistory)
    expect(FinanceHistory.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
