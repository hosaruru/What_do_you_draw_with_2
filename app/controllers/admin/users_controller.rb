class Admin::UsersController < ApplicationController
  before_action :set_q, only: [:index, :search]
  before_action :authenticate_admin!
  def index
    @users = User.page(params[:page])
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts  
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user =  User.find(params[:id])
    @user.update(user_params)
    redirect_to admin_user_path
  end
  
  def search
    @results = @q.result
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :email, :birth)
  end
  def set_q
    @q = User.ransack(params[:q])
  end
  def move_to_signed_in
    unless user_signed_in?
      redirect_to  admin_session_path
    end
  end
end
