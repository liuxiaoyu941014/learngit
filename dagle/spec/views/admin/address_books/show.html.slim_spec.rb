require 'rails_helper'

RSpec.describe "admin/address_books/show", type: :view do
  before(:each) do
    @address_book = assign(:address_book, AddressBook.new(id: 1,
      :user => nil,
      :name => "Name",
      :gender => "Gender",
      :mobile_phone => "Mobile Phone",
      :city => "City",
      :street => "Street",
      :house_number => "House Number",
      :note => "Note"
    ))
  end
  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Gender/)
    expect(rendered).to match(/Mobile Phone/)
    expect(rendered).to match(/City/)
    expect(rendered).to match(/Street/)
    expect(rendered).to match(/House Number/)
    expect(rendered).to match(/Note/)
  end
end
