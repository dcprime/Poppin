class FriendsController < ApplicationController
  
  before_action :require_user
  
  def index
  end
  
  def all
    @friends = current_user.friends.sort_by {|friend| friend.first_name }
  end
  
  def create
    if User.find_by(invite_id: params[:invite_code]).class == User
      if friendship_exits?
        flash[:notice] = "You are already friends with that person!"
      else
        set_friendship!
        flash[:notice] = "Your friend has been added (see Friend's list below)"
      end
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
  
end