class CommentsController < ApplicationController
  def new
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = @user

    if @comment.save
      redirect_to current_user_posts_all_path, notice: 'Comment successfully created.'
    else
      redirect_to user_posts_path, notice: 'Comment not created'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
