require 'rails_helper'

RSpec.describe "admin/forages/index", type: :view do
  before(:each) do
    assign(:forage_details, [
      Forage::Detail.new(id: 1,
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
      ),
      Forage::Detail.new(id: 2,
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
      )
    ])
  end
  it "renders a list of admin/forages" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
