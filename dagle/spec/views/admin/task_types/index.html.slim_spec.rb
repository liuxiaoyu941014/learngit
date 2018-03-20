require 'rails_helper'

RSpec.describe "admin/task_types/index", type: :view do
  before(:each) do
    assign(:task_types, [
      TaskType.new(id: 1,),
      TaskType.new(id: 2,)
    ])
  end
  it "renders a list of admin/task_types" do
    render
  end
end
