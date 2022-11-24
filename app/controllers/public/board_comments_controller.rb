class Public::BoardCommentsController < ApplicationController
  def create
    board = Board.find(params[:board_id])
    comment = current_user.board_comments.new(board_comment_params)
    comment.board_id = board.id
    comment.save
    redirect_to board_path(board)
  end
  def destroy
    BoardComment.find(params[:id]).destroy
    redirect_to board_path
  end
  private

  def board_comment_params
    params.require(:board_comment).permit(:board_comment)
  end

end
