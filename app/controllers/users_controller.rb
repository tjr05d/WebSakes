class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # from the aplication flash.each methods
      flash[:success] = "Welcome"
      redirect_to @user
    else
      render 'new'
    end
  end

  def connection_match
    @connection = Match.where(connection_id: @user.id)
  end

  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end
end
