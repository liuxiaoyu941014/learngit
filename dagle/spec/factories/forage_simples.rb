FactoryGirl.define do
  factory :forage_simple, class: 'Forage::Simple' do
    run_key nil
    catalog "MyString"
    title "MyString"
    url "MyString"
    features ""
    is_processed false
    processed_at "MyString"
  end
end
