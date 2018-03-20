require 'rails_helper'

RSpec.describe ArticleProduct::Create, type: :model do
  it do
    record = create(:article_product)
    true_of_false = ArticleProduct::Destroy.(record)
    expect(true_of_false).to be_a(ArticleProduct)
    expect(ArticleProduct.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
