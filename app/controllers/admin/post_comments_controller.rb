class Admin::PostCommentsController < ApplicationController
    def create
        post = Post.find(params[:post_id])
        comment = current_user.post_comments.new(post_comment_params)
        comment.post_id = post.id
        comment.save
        redirect_to post_path(post)
    end
def destroy
  @comment = PostComment.find(params[:id])
  if @comment.destroy
    redirect_to root_path, notice: 'コメントを削除しました'
  else
    flash.now[:alert] = 'コメント削除に失敗しました'
    render root_path
  end
end
   
    private
    
    def post_comment_params
        params.require(:post_comment).permit(:comment)
        end
end
