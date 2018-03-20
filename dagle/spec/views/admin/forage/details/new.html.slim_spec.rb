require 'rails_helper'

RSpec.describe "admin/forages/new", type: :view do
  before(:each) do
    assign(:forage_detail, Forage::Detail.new(
      :forage_simple => nil,
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => "",
      : => ""
    ))
  end
  it "renders new admin_forage form" do
    render
    assert_select "form[action=?][method=?]", admin_forage_details_path, "post" do

      assert_select "input#forage_detail_forage_simple_id[name=?]", "forage_detail[forage_simple_id]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"

      assert_select "input#forage_detail_[name=?]", "forage_detail[]"
    end
  end
end
