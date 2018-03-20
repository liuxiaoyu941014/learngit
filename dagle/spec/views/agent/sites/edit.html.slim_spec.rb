require 'rails_helper'

RSpec.describe "agent/sites/edit", type: :view do
  before(:each) do
    @site = assign(:site, Site.create!(id: 1, 
      :user => nil,
      :title => "MyString"
    ))
  end
  it "renders the edit agent_site form" do
    render
    assert_select "form[action=?][method=?]", agent_site_path(@site), "post" do

      assert_select "input#site_user_id[name=?]", "site[user_id]"

      assert_select "input#site_title[name=?]", "site[title]"
    end
  end
end
