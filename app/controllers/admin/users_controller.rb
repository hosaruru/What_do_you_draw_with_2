class Admin::UsersController < ApplicationController
  before_action :set_q, only: [:index, :search]
  def index
    @users = User.page(params[:page])
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts  
  end

  def edit
  end

  def update
  end
  
  def search
    @results = @q.result
  end

  private

  def set_q
    @q = User.ransack(params[:q])
  end
end
