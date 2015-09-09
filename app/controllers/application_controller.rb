class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  theme :theme_resolver
  before_action :set_locale
 

  protected

    def theme_resolver
      session[:theme] ||= "dark"
    end

    def configure_devise_permitted_parameters
      registration_params = [:nickname, :email, :password, :password_confirmation]

      if params[:action] == 'update'
        devise_parameter_sanitizer.for(:account_update) { 
          |u| u.permit(registration_params << :current_password)
        }
      elsif params[:action] == 'create'
        devise_parameter_sanitizer.for(:sign_up) { 
          |u| u.permit(registration_params) 
        }
      end
    end

    def set_locale
      if current_user 
        I18n.locale =  current_user.locale
      else
        I18n.locale =   params[:locale] || I18n.default_locale
      end
    end

    def default_url_options(options = {})
      { locale: I18n.locale }.merge options
    end

end
