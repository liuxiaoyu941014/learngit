require 'rails_helper'

RSpec.describe "admin/tasks/index", type: :view do
  before(:each) do
    assign(:tasks, [
      Task.new(id: 1,),
      Task.new(id: 2,)
    ])
  end
  it "renders a list of admin/tasks" do
    render
  end
end
