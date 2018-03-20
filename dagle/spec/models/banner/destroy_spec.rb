require 'rails_helper'

RSpec.describe Banner::Create, type: :model do
  it do
    record = create(:banner)
    true_of_false = Banner::Destroy.(record)
    expect(true_of_false).to be_a(Banner)
    expect(Banner.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
