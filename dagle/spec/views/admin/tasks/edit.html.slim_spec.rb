require 'rails_helper'

RSpec.describe "admin/tasks/edit", type: :view do
  before(:each) do
    @task = assign(:task, Task.create!(id: 1, ))
  end
  it "renders the edit admin_task form" do
    render
    assert_select "form[action=?][method=?]", admin_task_path(@task), "post" do
    end
  end
end
