class Public::PostCommentsController < ApplicationController
    def create
    @post = Post.find(params[:post_id])
    @comment = current_user.post_comments.new(post_comment_params)
    @comment.post_id = @post.id
        if @comment.save
           @post_comment = PostComment.new
           @comment.post.create_notification_post_comment!(current_user, @comment.id)
        else
          render :error
        end
    end  
    
    def destroy
        @post =  Post.find(params[:post_id])
        PostComment.find(params[:id]).destroy
        
    end
    
    private
    
    def post_comment_params
        params.require(:post_comment).permit(:comment)
    end
end