require "test_helper"

class Farmer::ReservationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get farmer_reservations_index_url
    assert_response :success
  end
end
