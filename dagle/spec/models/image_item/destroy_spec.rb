require 'rails_helper'

RSpec.describe ImageItem::Create, type: :model do
  it do
    record = create(:image_item)
    true_of_false = ImageItem::Destroy.(record)
    expect(true_of_false).to be_a(ImageItem)
    expect(ImageItem.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
