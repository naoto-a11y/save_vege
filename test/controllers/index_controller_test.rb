require "test_helper"

class IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get index_destroy_url
    assert_response :success
  end
end
