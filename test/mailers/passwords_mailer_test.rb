require "test_helper"

class PasswordsMailerTest < ActionMailer::TestCase
  test "reset" do
    user = users(:normal_user)
    mail = PasswordsMailer.reset(user)

    assert_equal "Reset your password", mail.subject
    assert_equal [ user.email_address ], mail.to
    assert_equal [ "noreply@pawbies.net" ], mail.from
    assert_match "You can reset your password within the next 15 minutes", mail.body.encoded
  end
end
