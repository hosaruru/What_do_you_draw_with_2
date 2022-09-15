require "test_helper"

class Public::ListsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get public_lists_index_url
    assert_response :success
  end

  test "should get show" do
    get public_lists_show_url
    assert_response :success
  end
end
