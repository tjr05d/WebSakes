class UsersController < ApplicationController

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:succes] = "Welcome"
      redirect_to @user
    else
      flass[:danger] = "Faillll......"
      render 'new'
  end


  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email,
                                   :password, :password_confirmation)
    end
end
