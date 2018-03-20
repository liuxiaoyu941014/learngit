require 'rails_helper'

RSpec.describe Keystore::Create, type: :model do
  it do
    record = create(:keystore)
    true_of_false = Keystore::Destroy.(record)
    expect(true_of_false).to be_a(Keystore)
    expect(Keystore.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
