require 'rails_helper'

RSpec.describe Charge::Create, type: :model do
  it do
    record = create(:charge)
    true_of_false = Charge::Destroy.(record)
    expect(true_of_false).to be_a(Charge)
    expect(Charge.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
