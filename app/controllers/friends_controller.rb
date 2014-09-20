class FriendsController < ApplicationController
  
  before_action :set_user
  before_action :require_user
  before_action :require_same_user
  
  def index
  end
  
  def create
    
  end
  
  def destroy
    delete_friendship!
    redirect_to :back
  end
  
  private
  
  def set_user
    @user = User.find(params[:user_id])
  end
  
end