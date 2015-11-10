class UsersController < ApplicationController
  before_action :current_user

  def index
  end

<<<<<<< HEAD
  def show

    @user = User.find(params[:id])

  end
=======
  
>>>>>>> 18609816740f2b0afc7bdde7750b50a59b867d50

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


  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end
end
