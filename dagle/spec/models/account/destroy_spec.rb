require 'rails_helper'

RSpec.describe Account::Create, type: :model do
  it do
    record = create(:account)
    true_of_false = Account::Destroy.(record)
    expect(true_of_false).to be_a(Account)
    expect(Account.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
