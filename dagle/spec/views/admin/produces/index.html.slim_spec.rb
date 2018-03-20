require 'rails_helper'

RSpec.describe "admin/produces/index", type: :view do
  before(:each) do
    assign(:produces, [
      Produce.new(id: 1,),
      Produce.new(id: 2,)
    ])
  end
  it "renders a list of admin/produces" do
    render
  end
end
