class ApplicationController < ActionController::Base

  helper :all
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper


  def createSession
    @api_key = '45406182'
    @api_secret = "ee066de80ac21bf1237fb6fdd595127a1d6e8ac7"

    @opentok = OpenTok::OpenTok.new @api_key, @api_secret
    @session = @opentok.create_session :media_mode => :routed
    @token = @session.generate_token
  end

#random_user is a method that selects a random user from the database to
#present to the current user
end
