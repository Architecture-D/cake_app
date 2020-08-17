require 'test_helper'

class CostomersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get costomers_show_url
    assert_response :success
  end

  test "should get edit" do
    get costomers_edit_url
    assert_response :success
  end

  test "should get update" do
    get costomers_update_url
    assert_response :success
  end

  test "should get hide" do
    get costomers_hide_url
    assert_response :success
  end

  test "should get delete" do
    get costomers_delete_url
    assert_response :success
  end

end
