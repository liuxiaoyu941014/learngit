require 'rails_helper'

RSpec.describe Notification::Create, type: :model do
  it do
    record = create(:notification)
    true_of_false = Notification::Destroy.(record)
    expect(true_of_false).to be_a(Notification)
    expect(Notification.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
