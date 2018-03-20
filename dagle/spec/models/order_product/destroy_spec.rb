require 'rails_helper'

RSpec.describe OrderProduct::Create, type: :model do
  it do
    record = create(:order_product)
    true_of_false = OrderProduct::Destroy.(record)
    expect(true_of_false).to be_a(OrderProduct)
    expect(OrderProduct.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
