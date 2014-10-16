class SessionsController < ApplicationController
  def new
  end

  def create
    session_params = get_secure_params
    user = User.find_by(email: session_params[:email].downcase) 
    if user && user.authenticate(session_params[:password])  # validate form info 
      log_in user   # stores session
      redirect_to user 
    else
      flash.now[:danger] = "Invalid email/password combination"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  private
    def get_secure_params
      params.require(:session).permit(:email, :password)
    end
end
