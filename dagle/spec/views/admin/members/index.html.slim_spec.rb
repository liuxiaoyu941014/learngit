require 'rails_helper'

RSpec.describe "admin/members/index", type: :view do
  before(:each) do
    assign(:members, [
      Member.new(id: 1,),
      Member.new(id: 2,)
    ])
  end
  it "renders a list of admin/members" do
    render
  end
end
