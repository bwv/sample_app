module SessionsHelper

  # Logs in the given user using the user id 
  def log_in(user)
    session[:user_id] = user.id 
  end

  # Logs out the given user -> remove session 
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  # Returns the current logged-in user (if any)
  # Used in _header.html:  link_to "Profile", current_user
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # Returns true if the user is logged in, false otherwise 
  def logged_in?
    !current_user.nil?
  end

end
