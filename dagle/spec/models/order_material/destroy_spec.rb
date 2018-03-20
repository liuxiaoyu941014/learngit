require 'rails_helper'

RSpec.describe OrderMaterial::Create, type: :model do
  it do
    record = create(:order_material)
    true_of_false = OrderMaterial::Destroy.(record)
    expect(true_of_false).to be_a(OrderMaterial)
    expect(OrderMaterial.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
