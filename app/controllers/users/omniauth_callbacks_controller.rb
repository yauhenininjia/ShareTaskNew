class Users::OmniauthCallbacksController < ApplicationController
  def facebook
  	redirect
  end

  def twitter
  	redirect
  end

  def vkontakte
  	redirect
  end

  private

  def redirect
  	info = request.env['omniauth.auth']
  	@user = User.find_by(provider: info['provider'], uid: info['uid'])
  	if @user.nil?
      info['info']['name'] = info['uid'] + ': ' +  info['info']['name']
      info['info']['name'] ||=  info['info']['first_name'] + info['info']['last_name']
      #info['provider'] ||= 'local'
  		@user = User.create(provider: info['provider'], uid: info['uid'], nickname: info['info']['name'])
  		@user.skip_confirmation!
  		@user.save
  	end
  	sign_in(:user, @user)
    redirect_to root_path
    flash[:notice] = "Signed in successfully"
  end
end
