require 'rails_helper'

RSpec.describe "admin/address_books/index", type: :view do
  before(:each) do
    assign(:address_books, [
      AddressBook.new(id: 1,
        :user => nil,
        :name => "Name",
        :gender => "Gender",
        :mobile_phone => "Mobile Phone",
        :city => "City",
        :street => "Street",
        :house_number => "House Number",
        :note => "Note"
      ),
      AddressBook.new(id: 2,
        :user => nil,
        :name => "Name",
        :gender => "Gender",
        :mobile_phone => "Mobile Phone",
        :city => "City",
        :street => "Street",
        :house_number => "House Number",
        :note => "Note"
      )
    ])
  end
  it "renders a list of admin/address_books" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Gender".to_s, :count => 2
    assert_select "tr>td", :text => "Mobile Phone".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Street".to_s, :count => 2
    assert_select "tr>td", :text => "House Number".to_s, :count => 2
    assert_select "tr>td", :text => "Note".to_s, :count => 2
  end
end
