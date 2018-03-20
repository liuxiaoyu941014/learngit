require 'rails_helper'

RSpec.describe "admin/keystores/index", type: :view do
  before(:each) do
    assign(:keystores, [
      Keystore.new(id: 1,
        :key => "Key",
        :value => "Value",
        :description => "Description"
      ),
      Keystore.new(id: 2,
        :key => "Key",
        :value => "Value",
        :description => "Description"
      )
    ])
  end
  it "renders a list of admin/keystores" do
    render
    assert_select "tr>td", :text => "Key".to_s, :count => 2
    assert_select "tr>td", :text => "Value".to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
