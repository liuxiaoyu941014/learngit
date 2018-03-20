FactoryGirl.define do
  factory :notification do
    user_id 1
    actor_id 1
    notify_type "MyString"
    target nil
    second_target nil
    third_target nil
    read_at "2017-08-04 11:23:46"
  end
end
