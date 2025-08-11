class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  around_action :switch_locale

  private
    def switch_locale(&action)
      I18n.with_locale(current_locale, &action)
    end

    def current_locale
      if params[:locale].present? && locale_available?(params[:locale])
        save_locale_cookie(params[:locale])
      elsif cookies.encrypted[:locale].present? && locale_available?(cookies.encrypted[:locale])
        cookies.encrypted[:locale]
      else
        I18n.default_locale
      end
    end

    def save_locale_cookie(locale)
      cookies.encrypted[:locale] = {
        value: locale.to_s,
        expires: 1.year.from_now,
        secure: Rails.env.production?,
        same_site: :lax,
        httponly: true
      }
      locale.to_s
    end

    def locale_available?(locale)
      I18n.available_locales.map(&:to_s).include?(locale.to_s)
    end
end
