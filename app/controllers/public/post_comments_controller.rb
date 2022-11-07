class Public::PostCommentsController < ApplicationController
    def create
        post = Post.find(params[:post_id])
        comment = current_user.post_comments.new(post_comment_params)
        comment.post_id = post.id        
        if comment.save
          redirect_to post_path(post)
        else
          flash[:alret] = "コメントを入力してください。"
          redirect_to post_path(post)
        end
    end
    
    private
    
    def post_comment_params
        params.require(:post_comment).permit(:comment)
        end
end
