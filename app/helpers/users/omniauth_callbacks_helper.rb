module Users::OmniauthCallbacksHelper

  def current_locale
    session[:locale] || I18n.default_locale
  end
  
end
