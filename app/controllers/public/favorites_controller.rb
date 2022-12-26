class Public::FavoritesController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @post_favorite = Favorite.new(user_id: current_user.id, post_id: params[:post_id])#各idを生成し、変数に格納
    @post_favorite.save
    redirect_to post_path(params[:post_id]) ###
    
    post = Post.find(params[:post_id])
    post.create_notification_favorite!(current_user)
  end

  def destroy
    @post_favorite = Favorite.find_by(user_id: current_user.id, post_id: params[:post_id])
    @post_favorite.destroy
    redirect_to post_path(params[:post_id]) 
  end
end
