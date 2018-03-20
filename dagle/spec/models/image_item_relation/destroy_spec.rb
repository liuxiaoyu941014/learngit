require 'rails_helper'

RSpec.describe ImageItemRelation::Create, type: :model do
  it do
    record = create(:image_item_relation)
    true_of_false = ImageItemRelation::Destroy.(record)
    expect(true_of_false).to be_a(ImageItemRelation)
    expect(ImageItemRelation.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
