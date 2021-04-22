class SessionsController < ApplicationController
  before_action :require_no_user!, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    login_user!(user)
    redirect_to cats_url
  end

  def destroy
    user = current_user
    if user
      user.reset_session_token!
      session[:session_token] = nil
      redirect_to cats_url
    end      
  end

  private
  def sessions_params
    params.require(:user).permit(:username, :password)
  end
end