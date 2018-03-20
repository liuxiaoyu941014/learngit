require 'rails_helper'

RSpec.describe "admin/staffs/index", type: :view do
  before(:each) do
    assign(:staffs, [
      Staff.new(id: 1,),
      Staff.new(id: 2,)
    ])
  end
  it "renders a list of admin/staffs" do
    render
  end
end
