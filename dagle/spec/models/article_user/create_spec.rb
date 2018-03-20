require 'rails_helper'

RSpec.describe ArticleUser::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:article_user)
    flag, record = ArticleUser::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:article_user).slice(:name)
  #   flag, _ = ArticleUser::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:article_user)
  #   attrs = attributes_for(:article_user)
  #   flag, _ = ArticleUser::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
