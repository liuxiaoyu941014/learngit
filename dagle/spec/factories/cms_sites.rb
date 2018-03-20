FactoryGirl.define do
  factory :cms_site, class: 'Cms::Site' do
    name "MyString"
    template "MyString"
    domain "MyString"
    description "MyString"
    is_published false
  end
end
