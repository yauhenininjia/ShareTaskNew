class UserController < ApplicationController
	def change_locale
	  #if current_user
	  #	current_user.locale = params[:locale]
	  #	current_user.save
	  #end
	  #session[:locale] = params[:locale]

	  redirect_to request.referer.sub URI(request.referer).path.split('/')[1], params[:loc]
	end
end
