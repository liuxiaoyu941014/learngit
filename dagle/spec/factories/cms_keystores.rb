FactoryGirl.define do
  factory :cms_keystore, class: 'Cms::Keystore' do
    site nil
    key "MyString"
    value "MyString"
    description "MyString"
  end
end
