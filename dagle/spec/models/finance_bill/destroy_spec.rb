require 'rails_helper'

RSpec.describe FinanceBill::Create, type: :model do
  it do
    record = create(:finance_bill)
    true_of_false = FinanceBill::Destroy.(record)
    expect(true_of_false).to be_a(FinanceBill)
    expect(FinanceBill.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
