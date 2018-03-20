FactoryGirl.define do
  factory :forage_run_key, class: 'Forage::RunKey' do
    source nil
    date "MyString"
    is_processed false
    processed_at "2017-06-21 15:57:28"
    total_count 1
  end
end
