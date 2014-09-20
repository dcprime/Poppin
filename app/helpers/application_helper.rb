module ApplicationHelper
  
  def display_datetime(dt)
    if logged_in? && !current_user.time_zone.blank?
      dt = dt.in_time_zone(current_user.time_zone)
    end    
    dt.strftime("%b %d, %Y at %r - %Z")
  end
  
  def user_full_name(user)
    user.first_name + ' ' + user.last_name
  end
  
end