require 'rails_helper'

RSpec.describe Article::Create, type: :model do
  it do
    record = create(:article)
    true_of_false = Article::Destroy.(record)
    expect(true_of_false).to be_a(Article)
    expect(Article.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
