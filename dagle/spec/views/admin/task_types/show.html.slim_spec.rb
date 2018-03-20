require 'rails_helper'

RSpec.describe "admin/task_types/show", type: :view do
  before(:each) do
    @task_type = assign(:task_type, TaskType.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
