require 'rails_helper'

RSpec.describe "admin/sites/edit", type: :view do
  before(:each) do
    @site = assign(:site, Site.create!(id: 1,
      :user => create(:agent),
      :title => "MyString",
      :description => "MyString"
    ))
  end
  it "renders the edit admin_site form" do
    render
    assert_select "form[action=?][method=?]", admin_site_path(@site), "post" do

      assert_select "select#site_user_id[name=?]", "site[user_id]"

      assert_select "input#site_title[name=?]", "site[title]"

      assert_select "input#site_description[name=?]", "site[description]"
    end
  end
end
