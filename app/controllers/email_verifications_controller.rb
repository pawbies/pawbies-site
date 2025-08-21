class EmailVerificationsController < ApplicationController
  before_action :require_own_user, only: :create
  before_action :set_user, only: :create
  before_action :set_user_by_token, only: :update

  def create
    EmailVerificationsMailer.verify(@user).deliver_now
    redirect_back fallback_location: root_path, notice: t(".mail_sent")
  end

  def update
    if @user.update(email_verified: true)
      redirect_to root_path, notice: t(".success")
    else
      redirect_to root_path, alert: t(".error")
    end
  end

  private

    def require_own_user
      redirect_back fallback_location: root_path, alert: t("not_authorized") unless authenticated? && params[:user_id].to_i == Current.user.id
    end

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_user_by_token
      @user = User.find_by_token_for!(:email_verification, params[:token])
    rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to root_path, alert: t(".link_was_invalid")
    end
end
