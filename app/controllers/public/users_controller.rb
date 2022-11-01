class Public::UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @post = @user.posts 
    @posts = @post.page(params[:page])
  end

  def edit
    @user = current_user
  end

  def update
    @user =  current_user
    @user.update(user_params)
    redirect_to user_path
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @posts = Post.page(params[:page])
  end
  
  
  private

  def user_params
    params.require(:user).permit(:user_name, :email)
  end
end
