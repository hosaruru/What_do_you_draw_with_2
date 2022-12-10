class Admin::PostsController < ApplicationController
  before_action :authenticate_admin!
  def index
  end

  def show
    @post = Post.find(params[:id])
    @post_comment = PostComment.new
    @posts = Post.page(params[:page])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(/[[:blank:]]/)
    @post.clean_pen   
    if @post.update(post_params)
      redirect_to admin_post_path(@post.id)
    else
      flash.now[:alert] = "*は必須です。"
      render:new
    end
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
