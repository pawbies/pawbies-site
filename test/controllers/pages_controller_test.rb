require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get homepage" do
    get root_url
    assert_response :success
  end

  test "should get about" do
    get about_url
    assert_response :success
  end

  test "should get contact" do
    get contact_url
    assert_response :success
  end

  test "should get privacy" do
    get privacy_url
    assert_response :success
  end

  test "should get imprint" do
    get imprint_url
    assert_response :success
  end
end
