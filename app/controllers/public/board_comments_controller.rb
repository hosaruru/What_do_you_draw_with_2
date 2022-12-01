class Public::BoardCommentsController < ApplicationController
  
  def create
    board = Board.find(params[:board_id])
    board_comment = current_user.board_comments.new(board_comment_params)# 新しくコメントを作る。paramsも取得。
    board_comment.board_id = params[:board_id]# idを元のboradのidと一致させる
    if board_comment.save
      board_comment.create_notification_board_comment!# board_commentに紐づいているボードを使って「create_notification_board_commentメソッドを呼び出す」
      redirect_to board_path(board_comment.board)
    else
      flash[:alret] = "コメントを入力してください。"
      redirect_to board_path(board_comment.board)
    end
  end
  
  def destroy
    board =  Board.find(params[:board_id])
    BoardComment.find(params[:id]).destroy
    redirect_to board_path(board)
  end
  private

  def board_comment_params
    params.require(:board_comment).permit(:answer)
  end

end
