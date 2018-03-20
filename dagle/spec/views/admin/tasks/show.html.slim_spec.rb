require 'rails_helper'

RSpec.describe "admin/tasks/show", type: :view do
  before(:each) do
    @task = assign(:task, Task.new(id: 1))
  end
  it "renders attributes in <p>" do
    render
  end
end
