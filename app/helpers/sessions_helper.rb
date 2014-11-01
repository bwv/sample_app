module SessionsHelper

  # Logs in the given user using the user id 
  def log_in(user)
    session[:user_id] = user.id 
  end

  # Remembers a user in a persistent session (cookie)
  def remember(user)
    user.remember   # --> sets remember_token for user, adds hashed token to DB
    cookies.permanent.signed[:user_id] = user.id   # --> stores cookie with hashed user_id 
    cookies.permanent[:remember_token] = user.remember_token # --> stores cookie with unhashed token
  end

  # Returns true if the given user is the current user
  def current_user?(user)
    user == current_user
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the given user - deleting the session and cookies
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Redirects to stored lcoation (or to the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.url if request.get?
  end

  # Returns the current logged-in user (if any)
  #   --- first checks session
  #   --- then checks cookies
  # <<< Used in _header.html:  link_to "Profile", current_user >>>
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise 
  def logged_in?
    !current_user.nil?
  end

end
