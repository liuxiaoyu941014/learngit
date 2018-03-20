require 'rails_helper'

RSpec.describe "admin/address_books/edit", type: :view do
  before(:each) do
    @address_book = assign(:address_book, AddressBook.create!(id: 1, 
      :user => nil,
      :name => "MyString",
      :gender => "MyString",
      :mobile_phone => "MyString",
      :city => "MyString",
      :street => "MyString",
      :house_number => "MyString",
      :note => "MyString"
    ))
  end
  it "renders the edit admin_address_book form" do
    render
    assert_select "form[action=?][method=?]", admin_address_book_path(@address_book), "post" do

      assert_select "input#address_book_user_id[name=?]", "address_book[user_id]"

      assert_select "input#address_book_name[name=?]", "address_book[name]"

      assert_select "input#address_book_gender[name=?]", "address_book[gender]"

      assert_select "input#address_book_mobile_phone[name=?]", "address_book[mobile_phone]"

      assert_select "input#address_book_city[name=?]", "address_book[city]"

      assert_select "input#address_book_street[name=?]", "address_book[street]"

      assert_select "input#address_book_house_number[name=?]", "address_book[house_number]"

      assert_select "input#address_book_note[name=?]", "address_book[note]"
    end
  end
end
