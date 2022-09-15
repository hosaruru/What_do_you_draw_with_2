class Public::UsersController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user =  current_user
    @user.update(user_params)
    redirect_to show_user_path
  end
  
  private

  def user_params
    params.require(:user).permit(:user_name, :email, :birth)
  end
end
