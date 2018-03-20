require 'rails_helper'

RSpec.describe ArticleUser::Create, type: :model do
  it do
    record = create(:article_user)
    true_of_false = ArticleUser::Destroy.(record)
    expect(true_of_false).to be_a(ArticleUser)
    expect(ArticleUser.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
