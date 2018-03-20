require 'rails_helper'

RSpec.describe MaterialWarehouseItem::Create, type: :model do
  it do
    record = create(:material_warehouse_item)
    true_of_false = MaterialWarehouseItem::Destroy.(record)
    expect(true_of_false).to be_a(MaterialWarehouseItem)
    expect(MaterialWarehouseItem.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
