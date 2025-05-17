require "test_helper"

class Farmers::ItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get farmers_items_new_url
    assert_response :success
  end

  test "should get show" do
    get farmers_items_show_url
    assert_response :success
  end

  test "should get edit" do
    get farmers_items_edit_url
    assert_response :success
  end

  test "should get update" do
    get farmers_items_update_url
    assert_response :success
  end

  test "should get destroy" do
    get farmers_items_destroy_url
    assert_response :success
  end
end
