require "test_helper"

class Public::DmRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get public_dm_rooms_show_url
    assert_response :success
  end
end
