class EventsController < ApplicationController
  def new
  end

  def create
    render plain: params[:events].inspect
  end
end


