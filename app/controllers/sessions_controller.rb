class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(:email => params[:email])
    if user && User.authenticate(params[:sessions][:password])
      #log user and redirect
      #call the method log_in in the Session helper
      log_in(user) # in the Session helper
    else
      flash.now[:danger] = "Invalid Email/Password combination "
      render 'new'
    end
  end

  # Sign out the the current user

  def destroy
    log_out # in the Session helper
    redirect_to root_url
  end
end
