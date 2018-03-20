require 'rails_helper'

RSpec.describe Forage::Detail::Create, type: :model do
  it do
    record = create(:detail)
    true_of_false = Forage::Detail::Destroy.(record)
    expect(true_of_false).to be_a(Forage::Detail)
    expect(Forage::Detail.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
