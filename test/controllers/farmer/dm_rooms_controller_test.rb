require "test_helper"

class Farmer::DmRoomsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get farmer_dm_rooms_show_url
    assert_response :success
  end
end
