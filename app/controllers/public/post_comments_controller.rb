class Public::PostCommentsController < ApplicationController
    def create
    post = Post.find(params[:post_id])
    comment = current_user.post_comments.new(post_comment_params)
    comment.post_id = post.id
        if comment.save
          comment.post.create_notification_post_comment!(current_user, comment.id)
          redirect_to post_path(post)
        else
          flash[:alret] = "コメントを入力してください。"
          redirect_to post_path(post)
        end
    end  
    
    def destroy
        post =  Post.find(params[:post_id])
        PostComment.find(params[:id]).destroy
        redirect_to post_path(post)
    end
    
    private
    
    def post_comment_params
        params.require(:post_comment).permit(:comment)
    end
end
