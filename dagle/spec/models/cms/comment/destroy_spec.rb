require 'rails_helper'

RSpec.describe Cms::Comment::Create, type: :model do
  it do
    record = create(:comment)
    true_of_false = Cms::Comment::Destroy.(record)
    expect(true_of_false).to be_a(Cms::Comment)
    expect(Cms::Comment.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
