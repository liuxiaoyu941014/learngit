require 'rails_helper'

RSpec.describe Cms::Keystore::Create, type: :model do
  it do
    record = create(:keystore)
    true_of_false = Cms::Keystore::Destroy.(record)
    expect(true_of_false).to be_a(Cms::Keystore)
    expect(Cms::Keystore.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
