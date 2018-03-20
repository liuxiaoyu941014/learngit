require 'rails_helper'

RSpec.describe Delivery::Create, type: :model do
  it do
    record = create(:delivery)
    true_of_false = Delivery::Destroy.(record)
    expect(true_of_false).to be_a(Delivery)
    expect(Delivery.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
