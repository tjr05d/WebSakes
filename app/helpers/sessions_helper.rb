module SessionsHelper

  # session => is a method, to check the user_id
  # and encrypt a cookie, secure one
  def log_in(user)
    session[:user_id] = user.id
  end

  # remember a user in the session, by calling the
  # remember method in the user model(user.remember)
  def remember(user)
    user.remember
    # set the cookies, => it take a hash
      # 1st set the user id
      # keep the cookie for x amount of time
      # user_id is unencrypted because of cookies method
      # .signed => to encrypted user_id cookie
    cookies.permanent.signed[:user_id] = user.id
      # 2nd we want to store user.remember_tocket
      # in cookies :remember_tocken
    cookies.permanent[:remember_token] = user.remember_token
  end

  #return the current logged-in user (if-any)
  def current_user
    #if current user close the session the user will go away
      # @current_user ||= User.find_by(id: session[:user_id])

     #if session[:user_id] is not nil, if exit we do this
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)

    # else if the user close the browser session[:user_id] = nil
    # so it check cookies.signed[:user_id] != nil, so there
    # is a persistent session
    elsif (user_id = cookies.signed[:user_id])
      # will find user by (:id cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      # if user is true and is authenticated? ????
      # log_in user
      # @current_user = user
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # return true if user is logged in
  def logged_in?
    current_user == true
  end

  # we only are allow to log_out current session
  # to forget the information,
  # of remember cookies, persistent session
  # forget a persistent session
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # if we call @current_user before redirecting is a problem
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

end
