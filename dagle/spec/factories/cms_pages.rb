FactoryGirl.define do
  factory :cms_page, class: 'Cms::Page' do
    channel nil
    title "MyString"
    short_title "MyString"
    properties "MyString"
    keywords "MyString"
    description "MyString"
    image_path "MyString"
    content "MyText"
  end
end
