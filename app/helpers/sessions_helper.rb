module SessionsHelper

  # session => is a method, to check the user_id
  # and encrypt a cookie, secure one
  def log_in(user)
    session[:user_id] = user.id
  end

  #retrieve the user
  #get the cookie and encrypted and return the
  # user_key
  def current_user
    @current_user ||= User.find_by(id: sessions[:user_id])
  end

  # return treu if user is logged in
  def logged_in?
    !current_user.nil?
  end

  # if we call @current_user before redirecting is a problem
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
end
