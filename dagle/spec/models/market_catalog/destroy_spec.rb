require 'rails_helper'

RSpec.describe MarketCatalog::Create, type: :model do
  it do
    record = create(:market_catalog)
    true_of_false = MarketCatalog::Destroy.(record)
    expect(true_of_false).to be_a(MarketCatalog)
    expect(MarketCatalog.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
