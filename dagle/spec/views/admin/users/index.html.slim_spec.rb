require 'rails_helper'

RSpec.describe "admin/users/index", type: :view do
  before(:each) do
    create(:user)
    create(:admin)
    assign(:admin_users, User.all.page(1))
  end
  it "renders a list of admin/users" do
    render
  end
end
