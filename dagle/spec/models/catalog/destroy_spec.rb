require 'rails_helper'

RSpec.describe Catalog::Create, type: :model do
  it do
    record = create(:catalog)
    true_of_false = Catalog::Destroy.(record)
    expect(true_of_false).to be_a(Catalog)
    expect(Catalog.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
