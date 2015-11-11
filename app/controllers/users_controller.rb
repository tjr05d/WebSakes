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
      log_in @user
      # from the aplication flash.each methods
      flash[:success] = "Welcome"
      # after create go to the matches_show_path
      redirect_to matches_show_path
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

   def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to matches_show_path
      # Handle a successful update.
    else
      render 'edit'
    end
  end


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                    :password, :password_confirmation,
                                    :contact_number, :twitter, :linkedin)
    end
end
