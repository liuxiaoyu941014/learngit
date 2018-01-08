require 'test_helper'

class SessionnewControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get sessionnew_create_url
    assert_response :success
  end

end
