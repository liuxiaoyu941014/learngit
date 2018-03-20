require 'rails_helper'

RSpec.describe "admin/produces/new", type: :view do
  before(:each) do
    assign(:produce, Produce.new())
  end
  it "renders new admin_produce form" do
    render
    assert_select "form[action=?][method=?]", admin_produces_path, "post" do
    end
  end
end
