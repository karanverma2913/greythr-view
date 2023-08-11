require "test_helper"

class HolidaysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get holidays_index_url
    assert_response :success
  end

  test "should get show" do
    get holidays_show_url
    assert_response :success
  end

  test "should get new" do
    get holidays_new_url
    assert_response :success
  end

  test "should get create" do
    get holidays_create_url
    assert_response :success
  end

  test "should get edit" do
    get holidays_edit_url
    assert_response :success
  end

  test "should get update" do
    get holidays_update_url
    assert_response :success
  end

  test "should get destroy" do
    get holidays_destroy_url
    assert_response :success
  end
end
