class Admin::PostsController < ApplicationController
  def index
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
  end

  def edit
  end

  def update
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to admin_post_path
    
    
  end
  private

  def post_params
    params.require(:post).permit(:tag, :software, :brush, :image, :comments, :image, :introduction)
  end
end
