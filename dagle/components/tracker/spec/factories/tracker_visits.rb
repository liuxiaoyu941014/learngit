FactoryGirl.define do
  factory :tracker_visit, class: 'Tracker::Visit' do
    session nil
    action nil
    user nil
    resource nil
    url "MyString"
    referer "MyString"
    payload "MyText"
    user_agent_data "MyString"
    ip_address "MyString"
  end
end
