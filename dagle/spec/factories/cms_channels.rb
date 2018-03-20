FactoryGirl.define do
  factory :cms_channel, class: 'Cms::Channel' do
    site nil
    parent_id 1
    title "MyString"
    short_title "MyString"
    properties "MyString"
    tmp_index "MyString"
    tmp_detail "MyString"
    keywords "MyString"
    description "MyString"
    image_path "MyString"
    content "MyText"
  end
end
