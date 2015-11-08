class ApplicationController < ActionController::Base

  helper :all


  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include UsersHelper

  def connection_match
    Match.where(connection_id: current_user.id)
  end

  helper_method :connection_match
  def create
    #when the first person decides to connect and the second oerson has not
    #selected to connect yet, a new pending match will be created in the
    #database with the default active attribute false
    @match = Match.new
    #the user who selects the match is set to the id of the current user
    @match.user = current_user
    #the id  person that they select will be set to the random_user is
    #which is the id of the person that is on the screen
    @match.connection = randomize_users[0]

    if @match.save
      # from the aplication flash.each methods
      flash[:success] = "connection pending"
      # redirect_to current_user
    else
      flash[:alert] = "Oops"

    end
  end

  def update
    @match.first.active = true

      flash[:success] = "You have a match!"

  end

  def user_clicks_button_to_connect
    #when a user clicks the button to connect with a user, we query the matches
    #table to see if the connection alrady exists, if it does we turn the
    #active value to true, if does not exist, we create the relationship

     @match = Match.where(user_id: randomize_users[0].id, connection_id: current_user.id)
     if @match.first.nil?
       puts @match
       puts "no match"
       create

       #is calling user params and that need to change
    else
      puts @match
      puts "match"
      update


    end
    render 'users/show'
  end

  helper_method :user_clicks_button_to_connect

#random_user is a method that selects a random user from the database to
#present to the current user

end
