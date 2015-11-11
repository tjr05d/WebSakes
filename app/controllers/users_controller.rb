class UsersController < ApplicationController
  before_action :current_user

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
      # after create go to the matches_show_path
      redirect_to matches_show_path
    else
      render 'new'
    end
  end


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                    :password, :password_confirmation,
                                    :contact_number, :twitter, :linkedin)
    end
end
