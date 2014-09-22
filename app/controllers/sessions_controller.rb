class SessionsController < ApplicationController
  
  def new
    if logged_in?
      redirect_to user_path(current_user)
    end
  end
  
  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      login_user!(user)
    else
      flash[:error] = "Your login information was incorrect"
      render :new
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have been logged out"
    redirect_to :root
  end
  
  private
  
  def login_user!(user)
    session[:user_id] = user.id
    flash[:notice] = "You have been logged in"
    redirect_to user_path(current_user)
  end
   
end