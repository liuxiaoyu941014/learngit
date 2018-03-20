FactoryGirl.define do
  factory :refund do
    pingpp_charge_id "MyString"
    event_id "MyString"
    order_no "MyString"
    description "MyText"
    charge "MyString"
    amount 1
    created 1
    succeed false
    status "MyString"
    time_succeed 1
    failure_code "MyString"
    failure_msg "MyString"
  end
end
