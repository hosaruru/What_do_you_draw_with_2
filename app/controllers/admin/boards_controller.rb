class Admin::BoardsController < ApplicationController
  before_action :authenticate_admin!
  def new
    @board = Board.new
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
    redirect_to admin_boards_path
  end
  
  def edit
    @board = Board.find(params[:id])
  end
    def update
    @board = Board.find(params[:id])
    @board.update(board_params)
    if @board.save
      redirect_to admin_board_path(@board)
    else
      flash.now[:alret] = "*は必須です。"
      render:edit
    end
  end
  
  private
  
  def board_params
    params.require(:board).permit(:question, :answer, :image, :headline)
  end
  
  # def ensure_user
  #   @boards = current_user.boards
  #   @board = @boards.find_by(id: params[:id])
  #   redirect_to root_path unless @board
  # end
end
