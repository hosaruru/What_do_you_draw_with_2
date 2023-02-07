class Public::BoardCommentsController < ApplicationController
  def create
    @board = Board.find(params[:board_id])
    @board_comment = current_user.board_comments.new(board_comment_params)
    @board_comment.board_id = @board.id
    if @board_comment.save
      # @board_comment.create_notification_board_comment!     
      @board_comment.create_notification_board_comment!
      @board_comment = BoardComment.new
      
    else
      render :error
    end
  end
  
  def destroy
    @board =  Board.find(params[:board_id])
    BoardComment.find(params[:id]).destroy
  end
  
  private

  def board_comment_params
    params.require(:board_comment).permit(:answer)
  end
end
