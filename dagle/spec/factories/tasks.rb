FactoryGirl.define do
  factory :task do
    site nil
    title "MyString"
    description "MyText"
    creator_id 1
    assignee_id 1
    resource nil
  end
end
