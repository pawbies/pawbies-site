require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:normal_user)
  end

  test "new" do
    get new_session_url
    assert_response :success
  end

  test "create" do
    # correct
    post session_url, params: { email_address: @user.email_address, password: "password" }
    assert_redirected_to root_url

    # incorrect
    post session_url, params: { email_address: @user.email_address, password: "password123" }
    assert_redirected_to new_session_path
    post session_url, params: { email_address: "incorrect@example.com", password: "password" }
    assert_redirected_to new_session_path
  end
end
