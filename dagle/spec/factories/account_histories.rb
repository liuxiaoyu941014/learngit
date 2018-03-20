FactoryGirl.define do
  factory :account_history do
    account nil
    amount "9.99"
    relation_account 1
    relation_type 1
    relation_date "2017-02-07"
  end
end
