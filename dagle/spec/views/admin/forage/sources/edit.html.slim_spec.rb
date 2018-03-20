require 'rails_helper'

RSpec.describe "admin/forages/edit", type: :view do
  before(:each) do
    @forage_source = assign(:forage_source, Forage::Source.create!(id: 1, ))
  end
  it "renders the edit admin_forage form" do
    render
    assert_select "form[action=?][method=?]", admin_forage_path(@forage_source), "post" do
    end
  end
end
