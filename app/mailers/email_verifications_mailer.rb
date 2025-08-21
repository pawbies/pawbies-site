class EmailVerificationsMailer < ApplicationMailer
  def verify(user)
    @user = user
    mail subject: t(".subject"), to: user.email_address
  end
end
