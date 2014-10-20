class SessionsController < ApplicationController
  def new
  end

  def create
    session = get_secure_params
    user = User.find_by(email: session[:email].downcase) 
    if user && user.authenticate(session[:password])  
      log_in user   # stores session
      session[:remember_me] == '1' ? remember(user) : forget(user)  # store cookie or not 
      redirect_back_or(user) # in case user wanted to go to edit page, else go to profile 
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private
    def get_secure_params
      params.require(:session).permit(:email, :password, :remember_me)
    end
end
