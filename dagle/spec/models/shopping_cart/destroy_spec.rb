require 'rails_helper'

RSpec.describe ShoppingCart::Create, type: :model do
  it do
    record = create(:shopping_cart)
    true_of_false = ShoppingCart::Destroy.(record)
    expect(true_of_false).to be_a(ShoppingCart)
    expect(ShoppingCart.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
