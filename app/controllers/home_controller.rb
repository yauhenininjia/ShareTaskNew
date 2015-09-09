class HomeController < ApplicationController
  def index
  end

  


  def switch_theme 
  	session[:theme] = params[:theme]
  	redirect_to :back
  end
  
end
