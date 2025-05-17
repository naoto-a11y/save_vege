require "test_helper"

class Farmer::FarmersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get farmer_farmers_show_url
    assert_response :success
  end

  test "should get edit" do
    get farmer_farmers_edit_url
    assert_response :success
  end

  test "should get update" do
    get farmer_farmers_update_url
    assert_response :success
  end

  test "should get unsubscribe" do
    get farmer_farmers_unsubscribe_url
    assert_response :success
  end

  test "should get withdraw" do
    get farmer_farmers_withdraw_url
    assert_response :success
  end

  test "should get cancel_reservation" do
    get farmer_farmers_cancel_reservation_url
    assert_response :success
  end
end
