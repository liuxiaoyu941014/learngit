require 'rails_helper'
RSpec.describe 'User::Update.()', type: :model do
  it 'password' do
    user = create(:user)
    old_password = user.encrypted_password
    new_password = user.password.reverse
    flag, user = User::Update.(user, password: new_password, password_confirmation: new_password)
    expect(flag).to be(true)
    expect(user.encrypted_password).to_not be(old_password)
  end
end
