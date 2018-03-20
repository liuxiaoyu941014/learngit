require 'rails_helper'

RSpec.describe Chat::Room::Create, type: :model do
  it do
    record = create(:room)
    true_of_false = Chat::Room::Destroy.(record)
    expect(true_of_false).to be_a(Chat::Room)
    expect(Chat::Room.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
