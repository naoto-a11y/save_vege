require "test_helper"

class Public::DmMessagesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get public_dm_messages_create_url
    assert_response :success
  end

  test "should get destroy" do
    get public_dm_messages_destroy_url
    assert_response :success
  end
end
