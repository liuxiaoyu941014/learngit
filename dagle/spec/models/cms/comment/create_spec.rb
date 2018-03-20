require 'rails_helper'

RSpec.describe Cms::Comment::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:comment)
    flag, record = Cms::Comment::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:comment).slice(:name)
  #   flag, _ = Cms::Comment::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:comment)
  #   attrs = attributes_for(:comment)
  #   flag, _ = Cms::Comment::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
