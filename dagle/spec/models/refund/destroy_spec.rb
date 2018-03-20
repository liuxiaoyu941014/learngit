require 'rails_helper'

RSpec.describe Refund::Create, type: :model do
  it do
    record = create(:refund)
    true_of_false = Refund::Destroy.(record)
    expect(true_of_false).to be_a(Refund)
    expect(Refund.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
