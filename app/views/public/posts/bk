class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: [:index, :search]
  before_action :ensure_user, only: [:edit, :update, :destroy]
  
  def index 
    #タグがクリックされたとき
    if params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: :desc).page(params[:page])
      @tag_name = "タグ：" + @tag.tag_name + " の一覧"
    else
      # @posts = Post.all.order(created_at: :desc).page(params[:page])
      @posts = Post.published.page(params[:page]).reverse_order
      @posts = @posts.where('location LIKE ?', "%#{params[:search]}%") if params[:search].present?
      @all_ranks = @posts.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
    end
      @tag_lists = Tag.all
  end 
  
  def rank
    @posts = Post.published.page(params[:page]).reverse_order
   @all_ranks = @posts.find(Favorite.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end
  
  def new
   @post = Post.new
   @pens = @post.pens.build
  end

  def create
    @post = Post.new(post_params)
    tag_list = params[:post][:tag_name].split(/[[:blank:]]/)
    @post.image.attach(params[:post][:image])
    @post.user_id = current_user.id
    if @post.save
      @post.save_posts(tag_list)
      redirect_to post_path(@post.id)
      flash[:notice] = ""
    else
      flash.now[:alret] = "*は必須です。"
      render:new
    end
  end

  def show
    @post = Post.find(params[:id])
    @software = Software.all
    @post_comment = PostComment.new
    @tag_lists = Tag.all
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(/[[:blank:]]/)
    @post.user_id = current_user.id
    @post.clean_pen
    if @post.update(post_params)
       @post.save_posts(tag_list)
      redirect_to post_path(@post.id)
    else
      flash.now[:alret] = "*は必須です。"
      render:edit
    end
  end
  
  def destroy
    @post = Post.find(params[:id])
    @post.clean_tag
    @post.destroy
    redirect_to root_path
  end
  
  def search
    @results = @q.result
    @posts = @results.page(params[:page])
  end
  
def confirm
  @posts = current_user.posts.draft.page(params[:page]).reverse_order
end
  private
  
  def set_q
    @q = Post.ransack(params[:q])
  end
  
  def post_params
    # :_destroyで、子モデルの削除及び編集の動作が利用可能
    params.require(:post).permit(:tag_name, :brush, :image, :comments, :image, :introduction, :twitter, :software_id, :status, pens_attributes:[:use_pen, :_destroy])
  end
  
  def ensure_user
    @posts = current_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to new_post_path unless @post
  end
end