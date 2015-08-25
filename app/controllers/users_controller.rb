class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def show
    @user = User.find(params[:id])
  end

  protected

  def user_params
    params.require(:user)
  end
end
