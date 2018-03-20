require 'rails_helper'

RSpec.describe MaterialWarehouse::Create, type: :model do
  it do
    record = create(:material_warehouse)
    true_of_false = MaterialWarehouse::Destroy.(record)
    expect(true_of_false).to be_a(MaterialWarehouse)
    expect(MaterialWarehouse.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
