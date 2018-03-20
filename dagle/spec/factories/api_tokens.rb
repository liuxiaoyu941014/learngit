FactoryGirl.define do
  factory :api_token do
    user_id nil
    token "MyString"
    device "MyString"
    expired_at "2017-03-16 21:20:07"
  end
end
