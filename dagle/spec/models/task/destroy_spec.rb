require 'rails_helper'

RSpec.describe Task::Create, type: :model do
  it do
    record = create(:task)
    true_of_false = Task::Destroy.(record)
    expect(true_of_false).to be_a(Task)
    expect(Task.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
