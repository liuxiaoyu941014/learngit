require 'rails_helper'

RSpec.describe MarketPage::Create, type: :model do
  it do
    record = create(:market_page)
    true_of_false = MarketPage::Destroy.(record)
    expect(true_of_false).to be_a(MarketPage)
    expect(MarketPage.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
