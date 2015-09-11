class UserController < ApplicationController
	def show
	end

	def change_locale
	  current_locale = URI(request.referer).path.split('/')[1]
	  if current_locale
	  	redirect_to request.referer.sub current_locale, params[:loc]
	  else
	  	redirect_to home_index_path locale: params[:loc]
	  end
	end
end
