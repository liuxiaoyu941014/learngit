require 'rails_helper'

RSpec.describe Logistic::Create, type: :model do
  it do
    record = create(:logistic)
    true_of_false = Logistic::Destroy.(record)
    expect(true_of_false).to be_a(Logistic)
    expect(Logistic.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
