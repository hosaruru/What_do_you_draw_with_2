class Public::UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
    @post = @user.posts.order(created_at: :desc).page(params[:page])
    @posts = @post.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user =  current_user
    @user.update(user_params)    
      if @user.save
        redirect_to user_path
      else
        flash.now[:alret] = "ユーザー名を入力してください。"
        render:edit
      end
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.order(created_at: :desc).find(favorites)
    @posts = Post.page(params[:page])
  end
  
  
  private

  def user_params
    params.require(:user).permit(:user_name, :image_local)
  end
end
