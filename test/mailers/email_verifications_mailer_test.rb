require "test_helper"

class EmailVerificationsMailerTest < ActionMailer::TestCase
  test "verify" do
    user = users(:normal_user)
    mail = EmailVerificationsMailer.verify(user)

    assert_equal "Verify your email", mail.subject
    assert_equal [ user.email_address ], mail.to
    assert_equal [ "noreply@pawbies.net" ], mail.from
    assert_match "Hello #{user.full_name}, you can verify your email", mail.body.encoded
  end
end
