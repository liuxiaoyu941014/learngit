require 'rails_helper'

RSpec.describe "admin/forages/edit", type: :view do
  before(:each) do
    @forage_simple = assign(:forage_simple, Forage::Simple.create!(id: 1, 
      :forage_run_key => nil,
      :catalog => "MyString",
      :title => "MyString",
      :url => "MyString"
    ))
  end
  it "renders the edit admin_forage form" do
    render
    assert_select "form[action=?][method=?]", admin_forage_path(@forage_simple), "post" do

      assert_select "input#forage_simple_forage_run_key_id[name=?]", "forage_simple[forage_run_key_id]"

      assert_select "input#forage_simple_catalog[name=?]", "forage_simple[catalog]"

      assert_select "input#forage_simple_title[name=?]", "forage_simple[title]"

      assert_select "input#forage_simple_url[name=?]", "forage_simple[url]"
    end
  end
end
