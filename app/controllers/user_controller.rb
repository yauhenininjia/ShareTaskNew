class UserController < ApplicationController
	def change_locale
	  redirect_to request.referer.sub URI(request.referer).path.split('/')[1], params[:loc] 
	end
end
