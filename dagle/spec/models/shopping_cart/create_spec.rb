require 'rails_helper'

RSpec.describe ShoppingCart::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:shopping_cart)
    flag, record = ShoppingCart::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:shopping_cart).slice(:name)
  #   flag, _ = ShoppingCart::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:shopping_cart)
  #   attrs = attributes_for(:shopping_cart)
  #   flag, _ = ShoppingCart::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
