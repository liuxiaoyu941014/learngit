require 'rails_helper'

RSpec.describe Chat::Message::Create, type: :model do
  it do
    record = create(:message)
    true_of_false = Chat::Message::Destroy.(record)
    expect(true_of_false).to be_a(Chat::Message)
    expect(Chat::Message.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
