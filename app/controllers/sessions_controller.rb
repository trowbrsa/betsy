class SessionsController < ApplicationController

  def new
  end

  def create
    data = params[:session_data]
    @user = User.find_by_username(data[:username])
    if !@user.nil?
      if @user.authenticate(data[:password])
        session[:user_id] = @user.id
        redirect_to root_path
      else
        flash.now[:error] = "Try again."
        render :new
      end
    else
      flash[:error] = "Register New Account"
      redirect_to new_user_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
