require 'rails_helper'

RSpec.describe MaterialPurchaseDetail::Create, type: :model do
  it do
    record = create(:material_purchase_detail)
    true_of_false = MaterialPurchaseDetail::Destroy.(record)
    expect(true_of_false).to be_a(MaterialPurchaseDetail)
    expect(MaterialPurchaseDetail.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
