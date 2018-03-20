require 'rails_helper'

RSpec.describe "admin/forages/new", type: :view do
  before(:each) do
    assign(:forage_run_key, Forage::RunKey.new(
      :source => nil,
      :date => "MyString"
    ))
  end
  it "renders new admin_forage form" do
    render
    assert_select "form[action=?][method=?]", admin_forage_run_keys_path, "post" do

      assert_select "input#forage_run_key_source_id[name=?]", "forage_run_key[source_id]"

      assert_select "input#forage_run_key_date[name=?]", "forage_run_key[date]"
    end
  end
end
