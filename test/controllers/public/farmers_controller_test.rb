require "test_helper"

class Public::FarmersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_farmers_show_url
    assert_response :success
  end
end
