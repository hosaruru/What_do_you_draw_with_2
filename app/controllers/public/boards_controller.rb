class Public::BoardsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_user, only: [:edit, :update, :destroy]
  
  def new
    @board = Board.new
  end
  
  def create
    @board = Board.new(board_params)
    @board.image.attach(params[:board][:image])
    @board.user_id = current_user.id
    if@board.save
      redirect_to board_path(@board.id)
    else
      flash.now[:alret] = "*は必須です。"
      render :new
    end
  end
  
  def index
    @boards = Board.all.order(created_at: :desc).page(params[:page]).per(10)
  end
  
  def show
    @board = Board.find(params[:id])
    @board_comment = BoardComment.new
  end
  
  def destroy
    @board = Board.find(params[:id])
    @board.destroy
    redirect_to boards_path
  end
  
  def edit
    @board = Board.find(params[:id])
  end
  
  def update
  @board = Board.find(params[:id])
  @board.user_id = current_user.id
  @board.update(board_params)
    if @board.save
      redirect_to board_path(@board)
    else
      flash.now[:alret] = "*は必須です。"
      render:edit
    end
  end
  
  private
  
  def board_params
    params.require(:board).permit(:question, :answer, :image, :headline)
  end
  
  def ensure_user
    @boards = current_user.boards
    @board = @boards.find_by(id: params[:id])
    redirect_to root_path unless @board
  end
end