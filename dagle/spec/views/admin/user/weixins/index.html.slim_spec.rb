require 'rails_helper'

RSpec.describe "admin/users/index", type: :view do
  before(:each) do
    assign(:user_weixins, [
      User::Weixin.new(id: 1,
        :user => nil,
        :name => "Name",
        :headshot => "Headshot",
        :city => "City",
        :province => "Province",
        :country => "Country",
        :gender => 2
      ),
      User::Weixin.new(id: 2,
        :user => nil,
        :name => "Name",
        :headshot => "Headshot",
        :city => "City",
        :province => "Province",
        :country => "Country",
        :gender => 2
      )
    ])
  end
  it "renders a list of admin/users" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Headshot".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "Province".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
