require "test_helper"

class Admin::IndexControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get admin_index_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_index_edit_url
    assert_response :success
  end

  test "should get new" do
    get admin_index_new_url
    assert_response :success
  end
end
