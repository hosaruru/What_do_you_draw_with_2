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
       @post.save_posts(tag_list)
      redirect_to admin_post_path(@post.id)
    else
      flash.now[:alret] = "*は必須です。"
      render:edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @user = @post.user.id
    @post.destroy
    redirect_to admin_user_path(@user)
  end
  private
  def move_to_signed_in
    unless user_signed_in?
      redirect_to  admin_session_path
    end
  end
  def post_params
    params.require(:post).permit(:tag_name, :brush, :image, :comments, :image, :introduction, :twitter, :software_id, pens_attributes:[:use_pen, :_destroy])
  end
end
