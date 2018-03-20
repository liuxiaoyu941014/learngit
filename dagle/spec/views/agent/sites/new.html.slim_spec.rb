require 'rails_helper'

RSpec.describe "agent/sites/new", type: :view do
  before(:each) do
    assign(:site, Site.new(
      :user => nil,
      :title => "MyString"
    ))
  end
  it "renders new agent_site form" do
    render
    assert_select "form[action=?][method=?]", agent_sites_path, "post" do

      assert_select "input#site_user_id[name=?]", "site[user_id]"

      assert_select "input#site_title[name=?]", "site[title]"
    end
  end
end
