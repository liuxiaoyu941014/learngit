require 'rails_helper'

RSpec.describe Permission::Create, type: :model do
  it do
    record = create(:permission)
    true_of_false = Permission::Destroy.(record)
    expect(true_of_false).to be_a(Permission)
    expect(Permission.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
