require 'rails_helper'

RSpec.describe Produce::Create, type: :model do
  it do
    record = create(:produce)
    true_of_false = Produce::Destroy.(record)
    expect(true_of_false).to be_a(Produce)
    expect(Produce.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
