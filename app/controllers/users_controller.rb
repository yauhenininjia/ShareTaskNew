class UsersController < ApplicationController
  require 'cloudinary'

  def show
    @user = User.find(params[:id])
    #@rating = 0.0
    #@user.tasks.each {|t| @rating += t.rates(:description).average :stars unless t.rates(:description).average(:stars).nil?} 
    @rating = rating @user#/= @user.tasks.count
    @answered = Attempt.where(user_id: params[:id], answered: true).count
    @attempts = Attempt.where(user_id: params[:id]).count
    @efficiency = (@answered / @attempts).round(1) if @attempts != 0
  end

  def edit
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

  def top
    @users = User.all.to_a
    @users.sort_by! {|u| rating u}
    @users = @users.take(10)
  end

  private
    def user_params
      params.require(:user).permit(:nickname)
    end

    def rating(user)
      rating = 0.0
      user.tasks.each {|t| rating += t.rates(:description).average :stars unless t.rates(:description).average(:stars).nil?} 
      if user.tasks.count != 0
        rating /= user.tasks.count 
      else
        rating = 0.0
      end
    end
end
