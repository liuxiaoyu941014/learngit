require 'rails_helper'

RSpec.describe ImageItemTag::Create, type: :model do
  it do
    record = create(:image_item_tag)
    true_of_false = ImageItemTag::Destroy.(record)
    expect(true_of_false).to be_a(ImageItemTag)
    expect(ImageItemTag.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
