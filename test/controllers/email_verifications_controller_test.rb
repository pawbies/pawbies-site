require "test_helper"

class EmailVerificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:normal_user)
    @user_two = users(:bf_user)

    @user.update!(email_verified: false)
  end

  test "create" do
    # not authenticated
    post email_verification_url(@user)
    assert_redirected_to new_session_url

    # auth own user
    auth_user(@user)
    assert_emails 1 do
      post email_verification_url(@user)
      assert_redirected_to root_path
    end

    # auth wrong user
    assert_emails 0 do
      post email_verification_url(@user_two)
      assert_redirected_to root_path
    end
  end

  test "update" do
    # not authenticated
    get update_email_verification_url(token: @user.generate_token_for(:email_verification))
    assert_redirected_to new_session_url

    # authenticated
    auth_user(@user)
    get update_email_verification_url(token: @user.generate_token_for(:email_verification))
    assert_redirected_to root_url
    @user.reload
    assert @user.email_verified
  end
end
