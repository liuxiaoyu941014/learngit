require 'rails_helper'

RSpec.describe "admin/produces/edit", type: :view do
  before(:each) do
    @produce = assign(:produce, Produce.create!(id: 1, ))
  end
  it "renders the edit admin_produce form" do
    render
    assert_select "form[action=?][method=?]", admin_produce_path(@produce), "post" do
    end
  end
end
