class SessionsController < ApplicationController
  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    if user.nil?
      flash[:error] = "invalid credentials"
      render :new
    else
      login!(user)
      redirect_to user_url(user)
    end
  end

  def new
  end

  def destroy
    logout!
    redirect_to root_url
  end
end