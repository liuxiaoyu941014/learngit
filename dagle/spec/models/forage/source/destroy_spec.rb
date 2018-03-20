require 'rails_helper'

RSpec.describe Forage::Source::Create, type: :model do
  it do
    record = create(:source)
    true_of_false = Forage::Source::Destroy.(record)
    expect(true_of_false).to be_a(Forage::Source)
    expect(Forage::Source.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
