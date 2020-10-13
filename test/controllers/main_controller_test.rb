require 'test_helper'

class MainControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get main_create_url
    assert_response :success
  end

  test "should get show" do
    get main_show_url
    assert_response :success
  end

end
