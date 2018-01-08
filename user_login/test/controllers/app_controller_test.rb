require 'test_helper'

class AppControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get app_new_url
    assert_response :success
  end

  test "should get create" do
    get app_create_url
    assert_response :success
  end

end
