require "test_helper"

class Public::BoardsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get public_boards_new_url
    assert_response :success
  end

  test "should get index" do
    get public_boards_index_url
    assert_response :success
  end

  test "should get show" do
    get public_boards_show_url
    assert_response :success
  end
end
