class Public::BoardsController < ApplicationController
  def new
    @board = Board.new
  end
  def create
    board = Board.find(params[:board_id])
    @board = current_user.board_comments.new(board_params)
    @board.user_id = board.id
    if @board.save
      @board.board.create_notification_board_comment!(current_user, answer.id)
      redirect_to board_path(@board.id)
    else
      flash.now[:alret] = "*は必須です。"
      render :new
    end
  end
  def index
    @boards = Board.all.order(created_at: :desc).page(params[:page])

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
  
  private
  
  def board_params
    params.require(:board).permit(:question, :answer, :image, :headline)
  end
end