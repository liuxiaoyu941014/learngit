require 'rails_helper'

RSpec.describe "admin/forages/edit", type: :view do
  before(:each) do
    @forage_run_key = assign(:forage_run_key, Forage::RunKey.create!(id: 1, 
      :source => nil,
      :date => "MyString"
    ))
  end
  it "renders the edit admin_forage form" do
    render
    assert_select "form[action=?][method=?]", admin_forage_path(@forage_run_key), "post" do

      assert_select "input#forage_run_key_source_id[name=?]", "forage_run_key[source_id]"

      assert_select "input#forage_run_key_date[name=?]", "forage_run_key[date]"
    end
  end
end
