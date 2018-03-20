require 'rails_helper'

RSpec.describe "admin/forages/new", type: :view do
  before(:each) do
    assign(:forage_source, Forage::Source.new())
  end
  it "renders new admin_forage form" do
    render
    assert_select "form[action=?][method=?]", admin_forage_sources_path, "post" do
    end
  end
end
