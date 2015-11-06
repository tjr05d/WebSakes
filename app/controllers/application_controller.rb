class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def connection_match
    Match.where(connection_id: @user.id) 
  end

  helper_method :connection_match

    private
#random_user is a method that selects a random user from the database to
#present to the current user
    def random_user
    User.order("RANDOM()").first
    end
#the helper method allows the method to be used in multiple places
    helper_method :random_user
end
