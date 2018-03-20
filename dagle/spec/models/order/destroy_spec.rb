require 'rails_helper'

RSpec.describe Order::Create, type: :model do
  it do
    record = create(:order)
    true_of_false = Order::Destroy.(record)
    expect(true_of_false).to be_a(Order)
    expect(Order.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
