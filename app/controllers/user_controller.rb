class UserController < ApplicationController
	def change_locale
	  if current_user
	  	current_user.locale = params[:locale]
	  	current_user.save
	  end
	  params[:path] += '?locale=' + params[:locale]
	  redirect_to params[:path]#root_path(:locale => params[:locale])
	end
end
