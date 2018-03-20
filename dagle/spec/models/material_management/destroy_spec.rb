require 'rails_helper'

RSpec.describe MaterialManagement::Create, type: :model do
  it do
    record = create(:material_management)
    true_of_false = MaterialManagement::Destroy.(record)
    expect(true_of_false).to be_a(MaterialManagement)
    expect(MaterialManagement.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
