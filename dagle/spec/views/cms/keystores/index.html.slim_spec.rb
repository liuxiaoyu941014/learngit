require 'rails_helper'

RSpec.describe "cms/keystores/index", type: :view do
  before(:each) do
    assign(:cms_keystores, [
      Cms::Keystore.new(id: 1,
        :site => nil,
        :key => "Key",
        :value => "Value",
        :description => "Description"
      ),
      Cms::Keystore.new(id: 2,
        :site => nil,
        :key => "Key",
        :value => "Value",
        :description => "Description"
      )
    ])
  end
  it "renders a list of cms/keystores" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
