class StaticPagesController < ApplicationController

  def home
    if current_user
      redirect_to matches_show_path
    end
  end

  def about
  end

  def index
  end
end
