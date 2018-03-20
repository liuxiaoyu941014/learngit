require 'rails_helper'
RSpec.describe 'User::Create.()', type: :model do
  it 'with mobile_number' do
    flag, user = User::Create.(mobile_phone: '13912345678')
    expect(flag).to be(true)
  end

  it 'without mobile_number' do
    flag, user = User::Create.({})
    expect(flag).to be(false)
  end
end