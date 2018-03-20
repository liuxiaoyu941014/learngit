require 'rails_helper'

RSpec.describe OrderDelivery::Create, type: :model do
  it do
    record = create(:order_delivery)
    true_of_false = OrderDelivery::Destroy.(record)
    expect(true_of_false).to be_a(OrderDelivery)
    expect(OrderDelivery.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
