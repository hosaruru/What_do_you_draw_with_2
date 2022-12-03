class Public::PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_q, only: [:index, :search]
  before_action :ensure_user, only: [:edit, :update, :destroy]
  def index   
    if params[:search].present?
      @posts = Post.posts_serach(params[:search]).page(params[:page])
    elsif params[:tag_id].present?
      @tag = Tag.find(params[:tag_id])
      @posts = @tag.posts.order(created_at: :desc).page(params[:page])
    else
      @posts = Post.all.order(created_at: :desc).page(params[:page])
    end
    @tag_lists = Tag.all
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

  end

  def update
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_name].split(/[[:blank:]]/)
    @post.user_id = current_user.id
    @post.clean_pen   
    if @post.update(hoge) 
       @post.save_posts(tag_list)
      redirect_to post_path(@post.id)
    else
      flash.now[:alert] = "*は必須です。"
      render:new
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
    @posts = Post.page(params[:page])
  end
  private
  def set_q
    @q = Post.ransack(params[:q])
  end
  def post_params
    params.require(:post).permit(:tag_name, :brush, :image, :comments, :image, :introduction, :twitter, :software_id, pens_attributes:[:use_pen, :_destroy])
  end
  def hoge
    post_params.merge!("pens_attributes" => post_params[:pens_attributes].select {|_, attributes| attributes[:use_pen].present? })
  end
  def ensure_user
    @posts = current_user.posts
    @post = @posts.find_by(id: params[:id])
    redirect_to new_post_path unless @post
  end
end
