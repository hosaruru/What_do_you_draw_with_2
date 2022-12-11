class Admin::BoardCommentsController < ApplicationController
  def destroy
    board =  Board.find(params[:board_id])
    BoardComment.find(params[:id]).destroy
    redirect_to admin_board_path(board)
  end
    
end
