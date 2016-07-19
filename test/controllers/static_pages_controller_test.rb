require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get static_pages_index_url
    assert_response :success
  end

  test "should get rules" do
    get static_pages_rules_url
    assert_response :success
  end

  test "should get help" do
    get static_pages_help_url
    assert_response :success
  end

  test "should get donate" do
    get static_pages_donate_url
    assert_response :success
  end

  test "should get dynmap" do
    get static_pages_dynmap_url
    assert_response :success
  end

end
