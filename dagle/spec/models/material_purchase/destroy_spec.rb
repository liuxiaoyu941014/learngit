require 'rails_helper'

RSpec.describe MaterialPurchase::Create, type: :model do
  it do
    record = create(:material_purchase)
    true_of_false = MaterialPurchase::Destroy.(record)
    expect(true_of_false).to be_a(MaterialPurchase)
    expect(MaterialPurchase.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
