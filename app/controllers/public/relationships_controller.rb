class Public::RelationshipsController < ApplicationController
  before_action :user_params
  def create
    current_user.follow(params[:user_id])

  end
  # フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])

  end
  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
    @url = request.url
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
    @url = request.url
  end
  
  private

  def user_params
    @user = User.find(params[:user_id])
  end
end
