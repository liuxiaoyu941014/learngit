FactoryGirl.define do
  factory :forage_detail, class: 'Forage::Detail' do
    simple nil
    url "MyString"
    migrate_to "MyString"
    can_purchase false
    purchase_url "MyString"
    title "MyString"
    keywords "MyString"
    image "MyString"
    description "MyString"
    content "MyString"
    date "MyString"
    time "MyString"
    address_line1 "MyString"
    address_line2 "MyString"
    phone "MyString"
    price "MyString"
    from "MyString"
    has_site false
    site_name "MyString"
    note "MyString"
    features ""
  end
end
