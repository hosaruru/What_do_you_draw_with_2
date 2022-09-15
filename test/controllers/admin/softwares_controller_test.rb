require "test_helper"

class Admin::SoftwaresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_softwares_index_url
    assert_response :success
  end

  test "should get create" do
    get admin_softwares_create_url
    assert_response :success
  end

  test "should get edit" do
    get admin_softwares_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_softwares_update_url
    assert_response :success
  end
end
