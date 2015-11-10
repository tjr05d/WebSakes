class ApplicationController < ActionController::Base

  helper :all
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper


#random_user is a method that selects a random user from the database to
#present to the current user

end
