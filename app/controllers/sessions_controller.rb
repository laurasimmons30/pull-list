class SessionsController < ApplicationController
  def create
    # user = User.find_or_create_by(twitter_uid: auth_hash["uid"], username: auth_hash["info"]["nickname"])
    session[:user_id] = user.id
    flash[:notice] = 'You have successfully signed in'
    
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been signed out."

    redirect_to root_path
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end
end
