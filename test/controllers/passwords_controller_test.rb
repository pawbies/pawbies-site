require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:normal_user)
  end

  test "new" do
    get new_password_url
    assert_response :success
  end

  test "create" do
    assert_emails 1 do
      post passwords_url, params: { email_address: @user.email_address }
      assert_redirected_to new_session_url
    end

    assert_emails 0 do
      post passwords_url, params: { email_address: "incorrect@example.com" }
      assert_redirected_to new_session_url
    end
  end

  test "edit" do
    get edit_password_url(@user.password_reset_token)
    assert_response :success

    get edit_password_url("incorrect")
    assert_redirected_to new_password_url
  end

  test "update" do
    # incorrect
    token = @user.password_reset_token
    original_digest = @user.password_digest
    patch password_url(token), params: { password: "updated", password_confirmation: "wrong" }
    assert_redirected_to edit_password_url(token)
    @user.reload
    assert_equal(original_digest, @user.password_digest)

    # correct
    original_digest = @user.password_digest
    patch password_url(@user.password_reset_token), params: { password: "updated", password_confirmation: "updated" }
    assert_redirected_to new_session_url
    @user.reload
    assert_not_equal(original_digest, @user.password_digest)
  end
end
