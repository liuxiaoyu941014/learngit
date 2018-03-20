require 'rails_helper'

RSpec.describe "admin/comments/index", type: :view do
  before(:each) do
    assign(:admin_comments, [
      Admin::Comment.new(id: 1,),
      Admin::Comment.new(id: 2,)
    ])
  end
  it "renders a list of admin/comments" do
    render
  end
end
