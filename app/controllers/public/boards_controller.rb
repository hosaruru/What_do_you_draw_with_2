class Public::BoardsController < ApplicationController
  def new
    @board = Board.new
  end
  def create
    @board = Board.new(board_params)
    @board.user_id = current_user.id
    @board.save
    redirect_to boards_path
  end
  def index
    @boards = Board.all

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
    params.require(:board).permit(:question, :answer, :image)
  end
end