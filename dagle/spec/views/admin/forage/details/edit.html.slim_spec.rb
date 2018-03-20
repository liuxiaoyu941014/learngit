require 'rails_helper'

RSpec.describe "admin/forages/edit", type: :view do
  before(:each) do
    @forage_detail = assign(:forage_detail, Forage::Detail.create!(id: 1, 
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
  it "renders the edit admin_forage form" do
    render
    assert_select "form[action=?][method=?]", admin_forage_path(@forage_detail), "post" do

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
