require 'rails_helper'

RSpec.describe "admin/task_types/new", type: :view do
  before(:each) do
    assign(:task_type, TaskType.new())
  end
  it "renders new admin_task_type form" do
    render
    assert_select "form[action=?][method=?]", admin_task_types_path, "post" do
    end
  end
end
