require 'rails_helper'

RSpec.describe "admin/task_types/edit", type: :view do
  before(:each) do
    @task_type = assign(:task_type, TaskType.create!(id: 1, ))
  end
  it "renders the edit admin_task_type form" do
    render
    assert_select "form[action=?][method=?]", admin_task_type_path(@task_type), "post" do
    end
  end
end
