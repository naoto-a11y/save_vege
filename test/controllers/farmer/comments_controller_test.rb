require "test_helper"

class Farmer::CommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get farmer_comments_create_url
    assert_response :success
  end

  test "should get destroy" do
    get farmer_comments_destroy_url
    assert_response :success
  end
end
