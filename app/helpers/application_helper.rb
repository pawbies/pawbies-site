module ApplicationHelper
  def censor?
    authenticated? && Current.user.role == "censored"
  end
end
