class UsersController < ApplicationController
  before_action :require_dashboard_access, only: :index
  layout "dashboard", only: :index

  def index
    @users = User.order(role: :desc)
  end

  private
    def require_dashboard_access
      redirect_back fallback_location: root_path, alert: t("not_authorized") unless authenticated? && Current.user.dashboard_access?
    end
end
