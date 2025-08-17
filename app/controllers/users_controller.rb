class UsersController < ApplicationController
  before_action :require_dashboard_access, only: :index
  before_action :require_user_access, only: %i[ show edit update destroy ]
  before_action :set_user, only: %i[ show edit update destroy ]
  layout "dashboard", only: :index

  def index
    @users = User.order(role: :desc)
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t(".updated_user")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    terminate_session if @user.id == Current.user&.id
    @user.destroy!

    redirect_to root_path, notice: t(".deleted_user")
  end

  private
    def require_dashboard_access
      redirect_back fallback_location: root_path, alert: t("not_authorized") unless authenticated? && Current.user.dashboard_access?
    end

    def require_user_access
      redirect_back fallback_location: root_path, alert: t("not_authorized") unless authenticated? && Current.user.user_access?(params[:id].to_i)
    end

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      unless Current.user&.role == "alex"
        params.expect(user: [ :email_address, :firstname, :lastname, :pfp ])
      else
        params.expect(user: [ :email_address, :firstname, :lastname, :pfp, :role ])
      end
    end
end
