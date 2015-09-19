class UsersController < ApplicationController
  require 'cloudinary'

  def show
    @user = User.find(params[:id])
    @rating = 0.0
    @user.tasks.each {|t| @rating += t.rates(:description).average :stars unless t.rates(:description).average(:stars).nil?} 
    @rating /= @user.tasks.count
  end

  def update
    @user = User.find(params[:id])
    @user.update user_params
  end

  def change_locale
	current_locale = URI(request.referer).path.split('/')[1]
	if current_locale
	  redirect_to request.referer.sub current_locale, params[:loc]
	 else
	  redirect_to home_index_path locale: params[:loc]
	end
  end


  def delete_image
    Cloudinary::Api.delete_resources(params[:public_id])
    respond_to do |format|
      format.js
    end
  end

  private
    def user_params
      params.require(:user).permit(:nickname)
    end
end
