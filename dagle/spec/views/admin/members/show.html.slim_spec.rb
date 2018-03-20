require 'rails_helper'

RSpec.describe "admin/members/show", type: :view do
  before(:each) do
    @member = assign(:member, Member.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
