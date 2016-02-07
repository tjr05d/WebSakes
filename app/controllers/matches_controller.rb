class MatchesController < ApplicationController

  def connection_match
    Match.where(connection_id: current_user.id)
  end

  helper_method :connection_match

  def show
    @now_user = current_user
    @matched_already = User.take_matches_out(@now_user)
    @potential_connection = User.random_connection(@matched_already)
  end

  def losMatch
    @now_user = current_user
    @combined_matches = Match.combined_matches(@now_user)
    @api_key = ENV["APIKEY"]
    @api_secret = ENV["APISECRET"]

    puts ENV["APIKEY"]
  end

  def create
    @api_key = ENV["APIKEY"]
    @api_secret = ENV["APISECRET"]

    @opentok = OpenTok::OpenTok.new @api_key, @api_secret
    @session = @opentok.create_session :media_mode => :routed
    @token = @session.generate_token
    #when the first person decides to connect and the second oerson has not
    #selected to connect yet, a new pending match will be created in the
    #database with the default active attribute false
    @match = Match.new
    #the user who selects the match is set to the id of the current user
    @match.user = current_user
    #the id  person that they select will be set to the random_user is
    #which is the id of the person that is on the screen
    @match.connection = User.find_by(id: params[:id])

    @match.session_id = @session.session_id

    @match.token = @token

    if @match.save
      # from the aplication flash.each methods
      flash.now[:success] = "connection pending"
      # redirect_to current_user
    else
      flash.now[:alert] = "Oops"

    end
  end

  def update
    if @match.update_attribute(:active, true)
      flash[:success] = "You have a match!"
      @match = nil
    else
      flash.now[:alert] = "Oh no"
    end
  end


  #when a user clicks the button to connect with a user, we query the matches
  #table to see if the connection alrady exists, if it does we turn the
  #active value to true, if does not exist, we create the relationship

  #use find_or_create_by method to search active record to see if the match exists annd if doesn't, it will create it with the state changed to false
  def user_clicks_button_to_connect

    @match = Match.where(user_id: params[:id], connection_id: current_user.id)

    if @match.first.nil?
      create
    else
     @match = Match.find_by(user_id: params[:id], connection_id: current_user.id)
     update
    end
    redirect_to matches_show_path
  end
end
