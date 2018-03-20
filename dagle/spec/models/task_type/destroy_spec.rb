require 'rails_helper'

RSpec.describe TaskType::Create, type: :model do
  it do
    record = create(:task_type)
    true_of_false = TaskType::Destroy.(record)
    expect(true_of_false).to be_a(TaskType)
    expect(TaskType.exists?(record.id)).to eq(false)
  end
  pending "add some examples to (or delete) #{__FILE__}"
end
