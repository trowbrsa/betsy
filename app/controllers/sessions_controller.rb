class SessionsController < ApplicationController

  def new
  end

  def create
    data = params[:session_data]
    @user = User.find_by_username(data[:username])
    if @user && @user.authenticate(data[:password])# User's email is in the system
      # user is authenticated
      session[:user_id] = @user.id
      flash[:success] = "Welcome, #{@user.name}"
      redirect_to root_path
    else
      # user not logged in
      flash.now[:danger] = "Invalid username/password combination"
      render :new
    end
  end

  def destroy
    reset_session
    flash[:danger] = "You have successfully logged out"
    redirect_to login_path
  end

end
