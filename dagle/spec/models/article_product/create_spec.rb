require 'rails_helper'

RSpec.describe ArticleProduct::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:article_product)
    flag, record = ArticleProduct::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:article_product).slice(:name)
  #   flag, _ = ArticleProduct::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:article_product)
  #   attrs = attributes_for(:article_product)
  #   flag, _ = ArticleProduct::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
