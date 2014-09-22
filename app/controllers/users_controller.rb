class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_user, only: [:edit, :update, :show]
  before_action :require_same_user, only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @remove_buttons = false
    @all_slots = sort_slots(@user)
    unless current_user.friends.include?(@user) || current_user == @user
      flash[:notice] = 'Sorry, that person is not your friend'
      redirect_to user_path(current_user)
    end
  end
  
  def create
    @user = User.new(user_params)
    @user.invite_id = generate_invite_id
    if @user.save
      if User.find_by(invite_id: params[:invite_code]).class == User
        set_friendship!
        flash[:notice] = "You have been registered and #{User.find_by(invite_id: params[:invite_code]).first_name} has been added to your friends list"
      elsif params[:invite_code].blank?
        flash[:notice] = "You have been registered"
      else
        flash[:notice] = "You have been registered, but your invite code was not valid. Please try again using the Add Friend link in the menu above."
      end
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:notice] = "Your profile has been updated"
      redirect_to user_path(@user)
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password, :time_zone, :first_name, :last_name, :invite_id)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def generate_invite_id
    random = SecureRandom.hex(n = 6)
    return random
  end
  
end