class ApplicationController < ActionController::Base
  helper_method :current_user, :signed_in?
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

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

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:username, :email, :password, :password_confirmation, :current_password) }
  end
end
