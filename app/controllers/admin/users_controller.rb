class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_q, only: [:index, :search]
  def index
    @users = User.page(params[:page])
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @post = @user.posts 
    @posts = @post.page(params[:page])
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
    params.require(:user).permit(:user_name, :email)
  end
  def set_q
    @q = User.ransack(params[:q])
  end
end
