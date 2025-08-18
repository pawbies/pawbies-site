class PasswordsController < ApplicationController
  allow_unauthenticated_access
  before_action :set_user_by_token, only: %i[ edit update ]

  def new
  end

  def create
    if user = User.find_by(email_address: params[:email_address])
      PasswordsMailer.reset(user).deliver_now # cant use deliver_later because it requires a worker process and im not paying for that on heroku
    end

    redirect_to new_session_path, notice: t(".password_reset_instructions_sent")
  end

  def edit
  end

  def update
    if @user.update(params.permit(:password, :password_confirmation))
      redirect_to new_session_path, notice: t(".reset")
    else
      redirect_to edit_password_path(params[:token]), alert: t(".passwords_didnt_match")
    end
  end

  private
    def set_user_by_token
      @user = User.find_by_password_reset_token!(params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to new_password_path, alert: t(".password_reset_link_was_invalid")
    end
end
