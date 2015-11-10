class SessionsController < ApplicationController

  def new
  end


  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      #log user and redirect
      #call the method log_in in the Session helper
      log_in(user) # in the Session helper
      # we want to check if the checkbox of remember_me = '1'
      # if is, we want to remember(user) else forget(user
      params[:session][:remember_me] ? remember(user) : forget(user)
        redirect_to matches_show_path
    else
      flash.now[:danger] = "Invalid Email/Password combination "
      render 'new'
    end
  end

  # Sign out the the current user
  def destroy
    log_out if logged_in?# in the Session helper
    redirect_to root_url
  end
end
