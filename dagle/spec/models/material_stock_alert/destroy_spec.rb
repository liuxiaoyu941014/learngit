require 'rails_helper'

RSpec.describe MaterialStockAlert::Create, type: :model do
  it do
    record = create(:material_stock_alert)
    true_of_false = MaterialStockAlert::Destroy.(record)
    expect(true_of_false).to be_a(MaterialStockAlert)
    expect(MaterialStockAlert.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
