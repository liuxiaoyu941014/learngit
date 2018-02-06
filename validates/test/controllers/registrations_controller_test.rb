require 'test_helper'

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get registrations_update_url
    assert_response :success
  end

end
