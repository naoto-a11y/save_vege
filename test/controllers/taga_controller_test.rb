require "test_helper"

class TagaControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get taga_index_url
    assert_response :success
  end
end
