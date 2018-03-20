require 'rails_helper'

RSpec.describe Forage::RunKey::Create, type: :model do
  it do
    record = create(:run_key)
    true_of_false = Forage::RunKey::Destroy.(record)
    expect(true_of_false).to be_a(Forage::RunKey)
    expect(Forage::RunKey.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
