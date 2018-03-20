require 'rails_helper'

RSpec.describe MarketTemplate::Create, type: :model do
  it do
    record = create(:market_template)
    true_of_false = MarketTemplate::Destroy.(record)
    expect(true_of_false).to be_a(MarketTemplate)
    expect(MarketTemplate.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
