class MatchesController < ApplicationController
  def new
    @match = Match.new
  end

  def create
    #when the first person decides to connect and the second oerson has not
    #selected to connect yet, a new pending match will be created in the
    #database with the default active attribute false
    @match = Match.new
    #the user who selects the match is set to the id of the current user
    @match.user = current_user.id
    #the id  person that they select will be set to the random_user is
    #which is the id of the person that is on the screen
    @match.connection = random_user.id

    if @match.save
      # from the aplication flash.each methods
      flash[:success] = "connection pending"
      redirect_to @user
    else
      flash[:alert] = "Oops"
      render 'new'
    end
  end

  def update
    @match.active = true

    if @match.save
      flash[:success] = "You have a match!"
      redirect_to @user
    else
      flash[:alert] = "Oh No!"
    end
  end

  def user_clicks_button_to_connect
    #when a user clicks the button to connect with a user, we query the matches
    #table to see if the connection alrady exists, if it does we turn the
    #active value to true, if does not exist, we create the relationship
    @matches = Match.where(user_id: random_user.id, connection_id: user.id)

    if @matches.exist?
      update
    else
      create
    end

  end
end
