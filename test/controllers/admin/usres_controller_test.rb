require "test_helper"

class Admin::UsresControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_usres_index_url
    assert_response :success
  end

  test "should get show" do
    get admin_usres_show_url
    assert_response :success
  end

  test "should get edit" do
    get admin_usres_edit_url
    assert_response :success
  end

  test "should get update" do
    get admin_usres_update_url
    assert_response :success
  end
end
