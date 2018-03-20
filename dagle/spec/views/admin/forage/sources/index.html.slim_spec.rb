require 'rails_helper'

RSpec.describe "admin/forages/index", type: :view do
  before(:each) do
    assign(:forage_sources, [
      Forage::Source.new(id: 1,),
      Forage::Source.new(id: 2,)
    ])
  end
  it "renders a list of admin/forages" do
    render
  end
end
