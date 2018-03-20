FactoryGirl.define do
  factory :cms_comment, class: 'Cms::Comment' do
    site nil
    contact "MyString"
    content "MyText"
    features ""
  end
end
