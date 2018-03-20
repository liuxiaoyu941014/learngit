require 'rails_helper'

RSpec.describe Vendor::Create, type: :model do
  it do
    record = create(:vendor)
    true_of_false = Vendor::Destroy.(record)
    expect(true_of_false).to be_a(Vendor)
    expect(Vendor.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
