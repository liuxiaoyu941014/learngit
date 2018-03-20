require 'rails_helper'

RSpec.describe Forage::Simple::Create, type: :model do
  it do
    record = create(:simple)
    true_of_false = Forage::Simple::Destroy.(record)
    expect(true_of_false).to be_a(Forage::Simple)
    expect(Forage::Simple.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
