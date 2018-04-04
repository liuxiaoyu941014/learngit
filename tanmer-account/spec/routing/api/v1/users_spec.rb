require "rails_helper"
RSpec.describe "routing to users" do
  it "routes to /api/v1/users/profile" do
    expect(:get => '/api/v1/users/profile').to route_to({
      controller: 'api/v1/users',
      action: 'profile'
    })
  end
end