class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in?
  protect_from_forgery with: :exception

  Dir['app/services/*.rb'].each do |f|
    basename = File.basename(f)
    require_relative "../services/#{basename}"
  end

  # current user helper
  def current_user
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def signed_in?
    current_user.present?
  end

  def authenticate!
    unless signed_in?
      flash[:notice] = 'You must sign in'
      redirect_to root_path
    end
  end
end
