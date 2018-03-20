require 'rails_helper'

RSpec.describe Task::Create, type: :model do
  it 'with valid attributes' do
    attrs = attributes_for(:task)
    flag, record = Task::Create.(attrs)
    expect(flag).to eq(true)
    attrs.each_pair do |k, v|
      expect(record.send(k)).to eq(v)
    end
  end

  # it 'without title' do
  #   attrs = attributes_for(:task).slice(:name)
  #   flag, _ = Task::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  # it 'with existing record' do
  #   create(:task)
  #   attrs = attributes_for(:task)
  #   flag, _ = Task::Create.(attrs)
  #   expect(flag).to eq(false)
  # end

  pending "add some examples to (or delete) #{__FILE__}"
end
