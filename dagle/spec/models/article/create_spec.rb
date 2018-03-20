require 'rails_helper'

RSpec.describe Article::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:article)
    flag, record = Article::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:article).slice(:name)
  #   flag, _ = Article::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:article)
  #   attrs = attributes_for(:article)
  #   flag, _ = Article::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
