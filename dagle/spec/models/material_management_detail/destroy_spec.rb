require 'rails_helper'

RSpec.describe MaterialManagementDetail::Create, type: :model do
  it do
    record = create(:material_management_detail)
    true_of_false = MaterialManagementDetail::Destroy.(record)
    expect(true_of_false).to be_a(MaterialManagementDetail)
    expect(MaterialManagementDetail.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
