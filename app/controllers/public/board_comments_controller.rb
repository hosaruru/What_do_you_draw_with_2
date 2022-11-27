class Public::BoardCommentsController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    answer = current_user.board_comments.new(board_comment_params)
    answer.board_id = board.id
    answer.save
    redirect_to board_path(board)

  end
  def destroy
    BoardComment.find(params[:id]).destroy
    redirect_to board_path
  end
  private

  def board_comment_params
    params.require(:board_comment).permit(:answer)
  end

end
