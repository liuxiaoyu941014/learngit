require 'rails_helper'

RSpec.describe MaterialCatalog::Create, type: :model do
  it do
    record = create(:material_catalog)
    true_of_false = MaterialCatalog::Destroy.(record)
    expect(true_of_false).to be_a(MaterialCatalog)
    expect(MaterialCatalog.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
