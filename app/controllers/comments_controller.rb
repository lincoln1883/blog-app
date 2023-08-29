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
      redirect_to user_posts_url, notice: 'Comment successfully created.'
    else
      render :new, status: :unprocessable_entity
      flash[:alert] = 'There was an error saving this comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
