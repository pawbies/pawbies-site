class EmailVerificationsController < ApplicationController
  before_action :set_user, only: :create
  before_action :set_user_by_token, only: :update

  def create
    # send mail
  end

  def update
    # set email as verified
  end

  private
    def set_user
      @user = User.find(params[:user_id])
    end

    def set_user_by_token
      @user = User.find_by_token_for!(:email_verification, params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to root_path, alert: t(".link_was_invalid")
    end
end
