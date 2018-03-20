require 'rails_helper'

RSpec.describe "admin/produces/show", type: :view do
  before(:each) do
    @produce = assign(:produce, Produce.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
