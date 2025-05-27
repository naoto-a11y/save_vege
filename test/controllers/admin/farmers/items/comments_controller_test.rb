require "test_helper"

class Admin::Farmers::Items::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_farmers_items_comments_index_url
    assert_response :success
  end

  test "should get destroy" do
    get admin_farmers_items_comments_destroy_url
    assert_response :success
  end
end
