FactoryGirl.define do
  factory :charge do
    order nil
    pingpp_charge_id "MyString"
    pingpp_channel "MyString"
    client_ip "MyString"
    pingpp_transaction_no "MyString"
    pingpp_paid false
    pingpp_refunded false
    pingpp_time_paid 1
    pingpp_time_created 1
  end
end
