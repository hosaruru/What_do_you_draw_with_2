class Admin::PostsController < ApplicationController
  before_action :move_to_signed_in
  def index
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to admin_post_path
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_posts_path
  end
  private
  def move_to_signed_in
    unless user_signed_in?
      redirect_to  admin_session_path
    end
  end
  def post_params
    params.require(:post).permit(:tag, :software, :brush, :image, :comments, :image, :introduction)
  end
end
