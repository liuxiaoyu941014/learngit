require 'rails_helper'

RSpec.describe Classorder::Create, type: :model do
  it do
    record = create(:classorder)
    true_of_false = Classorder::Destroy.(record)
    expect(true_of_false).to be_a(Classorder)
    expect(Classorder.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
