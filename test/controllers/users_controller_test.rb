require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:normal_user)
    @user_bf = users(:bf_user)
    @user_alex = users(:alex_user)
  end

  test "index" do
    # not authenticated
    get users_url
    assert_redirected_to new_session_url

    # normal user
    auth_user(@user)
    get users_url
    assert_redirected_to root_url

    # bf user
    auth_user(@user_bf)
    get users_url
    assert_response :success

    # alex user
    auth_user(@user_alex)
    get users_url
    assert_response :success
  end

  test "new" do
    get new_user_url
    assert_response :success
  end

  test "create" do
    assert_difference("User.count") do
      post users_url, params: { user: { email_address: "new@example.com", firstname: "new", lastname: "example", password: "password", password_confirmation: "password" } }
      assert_redirected_to root_url
    end

    assert_no_difference("User.count") do
      post users_url, params: { user: { email_address: "new@example.com", firstname: "new", lastname: "example", password: "password", password_confirmation: "wrongpassword" } }
      assert_response :unprocessable_content
      assert_template :new
    end
  end

  test "show" do
    # not authenticated
    get user_url(@user)
    assert_redirected_to new_session_url

    # normal user
    auth_user(@user)
    get user_url(@user)
    assert_response :success
    auth_user(@user)
    get user_url(@user_alex)
    assert_redirected_to root_url

    # bf user
    auth_user(@user_bf)
    get user_url(@user)
    assert_redirected_to root_url
    get user_url(@user_bf)
    assert_response :success

    # alex user
    auth_user(@user_alex)
    get user_url(@user)
    assert_response :success
    get user_url(@user_alex)
    assert_response :success
  end

    test "edit" do
    # not authenticated
    get edit_user_url(@user)
    assert_redirected_to new_session_url

    # normal user
    auth_user(@user)
    get edit_user_url(@user)
    assert_response :success
    auth_user(@user)
    get edit_user_url(@user_alex)
    assert_redirected_to root_url

    # bf user
    auth_user(@user_bf)
    get edit_user_url(@user)
    assert_redirected_to root_url
    get edit_user_url(@user_bf)
    assert_response :success

    # alex user
    auth_user(@user_alex)
    get edit_user_url(@user)
    assert_response :success
    get edit_user_url(@user_alex)
    assert_response :success
  end

  test "update" do
    # not authenticated
    patch user_url(@user), params: { user: { email_address: "newunauth@example.com" } }
    assert_redirected_to new_session_url

    # normal user
    auth_user(@user)
    patch user_url(@user), params: { user: { email_address: "newnormal@example.com" } }
    assert_redirected_to user_url(@user)
    patch user_url(@user), params: { user: { email_address: "" } }
    assert_response :unprocessable_content
    assert_template :edit
    patch user_url(@user_alex), params: { user: { email_address: "newnormal@example.com" } }
    assert_redirected_to root_url

    # bf user
    auth_user(@user_bf)
    patch user_url(@user_bf), params: { user: { email_address: "new@example.com" } }
    assert_redirected_to user_url(@user_bf)
    patch user_url(@user_bf), params: { user: { email_address: "" } }
    assert_response :unprocessable_content
    assert_template :edit
    patch user_url(@user_alex), params: { user: { email_address: "new@example.com" } }
    assert_redirected_to root_url

    # alex user
    auth_user(@user_alex)
    patch user_url(@user_alex), params: { user: { email_address: "newalex@example.com" } }
    assert_redirected_to user_url(@user_alex)
    patch user_url(@user_alex), params: { user: { email_address: "" } }
    assert_response :unprocessable_content
    assert_template :edit
    patch user_url(@user), params: { user: { email_address: "newuser@example.com" } }
    assert_redirected_to user_url(@user)
  end

  test "destroy normal" do
    # not authenticated
    delete user_url(@user)
    assert_redirected_to new_session_url

    auth_user(@user)
    assert_no_difference("User.count") do
      delete user_url(@user_bf)
      assert_redirected_to root_path
    end
    assert_no_difference("User.count") do
      delete user_url(@user_alex)
      assert_redirected_to root_path
    end
    assert_difference("User.count", -1) do
      delete user_url(@user)
      assert_redirected_to root_path
    end
  end

  test "destroy bf" do
    auth_user(@user_bf)
    assert_no_difference("User.count") do
      delete user_url(@user)
      assert_redirected_to root_path
    end
    assert_no_difference("User.count") do
      delete user_url(@user_alex)
      assert_redirected_to root_path
    end
    assert_difference("User.count", -1) do
      delete user_url(@user_bf)
      assert_redirected_to root_path
    end
  end

  test "destroy alex" do
    auth_user(@user_alex)
    assert_difference("User.count", -1) do
      delete user_url(@user_bf)
      assert_redirected_to root_path
    end
    assert_difference("User.count", -1) do
      delete user_url(@user)
      assert_redirected_to root_path
    end
    assert_difference("User.count", -1) do
      delete user_url(@user_alex)
      assert_redirected_to root_path
    end
  end
end
