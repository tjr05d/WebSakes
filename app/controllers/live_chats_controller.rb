class LiveChatsController < ApplicationController
  def index
    api_key = 45406182        # Replace with your OpenTok API key.
    api_secret = "ee066de80ac21bf1237fb6fdd595127a1d6e8ac7"  # Replace with your OpenTok API secret.

    opentok = OpenTok::OpenTok.new api_key, api_secret
    session = opentok.create_session :media_mode => :routed
    token = session.generate_token
  end
end
