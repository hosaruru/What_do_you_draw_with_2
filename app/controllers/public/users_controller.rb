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
      if @user.save
        redirect_to user_path
      else
        flash.now[:alret] = "未入力の箇所があります"
        render:edit
      end
  end
  
  def favorites
    @user = User.find(params[:id])
    favorites= Favorite.where(user_id: @user.id).pluck(:post_id)
    @favorite_posts = Post.find(favorites)
    @posts = Post.page(params[:page])
  end
  
  
  private

  def user_params
    params.require(:user).permit(:user_name, :image_local)
  end
end
