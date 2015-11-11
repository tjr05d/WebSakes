class UsersController < ApplicationController
  before_action :current_user
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]



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
      flash[:success] =  "Weclome #{current_user.first_name}  😃  😃  😃  😃 "
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

  def destroy
    User.find(params[:id]).destroy
    flash[:danger] = "Sorry, to see you go! 😱 😥 😭 😭"
    redirect_to root_path
  end


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                    :password, :password_confirmation,
                                    :contact_number, :twitter, :linkedin)
    end

   # Before filters

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(matches_show_path) unless @user == current_user
    end
end
