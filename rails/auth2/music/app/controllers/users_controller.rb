class UsersController < ApplicationController
  before_action :require_current_user!, except: [:index, :create, :new]
  before_action :require_author_only!, except: [:index, :create, :new]
  

  def index
    @users = User.all
    render :index
  end

  def create
    @user = User.new(user_params)
  

    if @user.save
      login!(user)
      redirect_to user_url(user)
    else
      flash[:error] = "invalid credentials"
      render :new
    end
  end

  def new
    @user = User.new
    render :new
  end

  def show
    @user = User.find_by(session_token: session[:session_token])
    render :show
  end

  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
