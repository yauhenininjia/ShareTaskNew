class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  before_action :configure_devise_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception
  theme :theme_resolver
  before_action :set_locale
  before_action :tag_cloud
  helper_method :tag_separator, :currnet_locale

  protected

    def theme_resolver
      session[:theme] ||= "light"
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
        locale = request.fullpath.split('/')[1]
        if I18n.locale_available? locale
          I18n.locale =  request.fullpath.split('/')[1] 
          session[:locale] = locale
        end
    end 

    def tag_separator
      ', '
    end

    def current_locale
      session[:locale] || I18n.default_locale
    end

    def tag_cloud
      #@tags = Task.tag_counts_on(:tags)
      @tags = ActsAsTaggableOn::Tag.most_used(20)
    end

    def per_page
      5
    end
end
