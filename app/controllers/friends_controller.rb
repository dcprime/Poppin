class FriendsController < ApplicationController
  
  before_action :set_user
  before_action :require_user
  before_action :require_same_user
  
  def index
  end
  
  def create
    if User.find_by(invite_id: params[:invite_code]).class == User
        set_friendship!
        flash[:notice] = "Your friend has been added (see Friend's list below)"
      elsif params[:invite_code].blank?
        flash[:notice] = "No invite code entered - please try again"
      else
        flash[:notice] = "The invite code was not valid - please try again"
      end
    redirect_to :back
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