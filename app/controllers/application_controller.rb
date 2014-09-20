class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to do that."
      redirect_to login_path
    end
  end
  
  def require_same_user
    if current_user != @user
      access_denied
    end
  end
  
  def access_denied
    flash[:error] = "You can't do that."
    redirect_to root_path
  end
  
  def friendship_exits?
    other_friend = User.find_by(invite_id: params[:invite_code])
    Friendship.exists?(current_user.friendships.find_by(friend_id: other_friend.id))
  end
  
  def set_friendship!
    other_friend = User.find_by(invite_id: params[:invite_code])
    @user.friends << other_friend
    other_friend.friends << @user
  end
  
  def delete_friendship!
    friend = current_user.friends.find_by(id: params[:id])
    friendship_1 = current_user.friendships.find_by(friend_id: params[:id])
    friendship_2 = friend.friendships.find_by(friend_id: params[:user_id])
    friendship_1.destroy
    friendship_2.destroy
  end
  
end