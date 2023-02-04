class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :post_params

  def create
    Favorite.create(user_id: current_user.id, post_id: params[:id])
    @post.create_notification_favorite!(current_user)
  end

  def destroy
    Favorite.find_by(user_id: current_user.id, post_id: params[:id]).destroy
  end

  private

  def post_params
    @post = Post.find(params[:id])
  end
end
