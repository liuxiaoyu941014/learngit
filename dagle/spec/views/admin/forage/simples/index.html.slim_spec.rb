require 'rails_helper'

RSpec.describe "admin/forages/index", type: :view do
  before(:each) do
    assign(:forage_simples, [
      Forage::Simple.new(id: 1,
        :forage_run_key => nil,
        :catalog => "Catalog",
        :title => "Title",
        :url => "Url"
      ),
      Forage::Simple.new(id: 2,
        :forage_run_key => nil,
        :catalog => "Catalog",
        :title => "Title",
        :url => "Url"
      )
    ])
  end
  it "renders a list of admin/forages" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Catalog".to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Url".to_s, :count => 2
  end
end
